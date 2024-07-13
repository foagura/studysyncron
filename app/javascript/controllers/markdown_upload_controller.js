import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage"

// Connects to data-controller="markdown-upload"
export default class extends Controller {
  static values = { url: String };
  // textareaに対するinputイベントの監視
  connect() {
    this.element.addEventListener('input', (e) => this.monitoringOfMarkdownUrl(e));
  }

  // ドロップされたファイルを取得し、ファイルのアップロード処理を実行
  dropUpload(e){
    e.preventDefault();
    Array.from(e.dataTransfer.files).forEach(file => this.uploadFile(file));
  }


  // ファイルのアップロード処理
  uploadFile(file){

    // ファイル形式の判定結果が対応ファイル以外だった場合、メッセージを表示し処理を終了
    if (!this.isValidFileType(file)) {
      alert("アップロード可能の画像形式がJPEG, PNG, GIFです。ファイル形式をご確認ください。");
      return;
    }

    // ファイルサイズの判定結果が1MBを超えていた場合、メッセージを表示し処理を終了
    if (!this.isValidFileSize(file)) {
      alert("1MB以下の画像をアップロードしてください。");
      return;
    }

    const upload = new DirectUpload(file, this.urlValue);
    upload.create((error, blob) => {
      if (error) {
        console.log(error);
      } else {
        // textareaに埋め込むmarkdownUrlの生成～挿入まで
        const text = this.markdownUrl(blob);
        const start = this.element.selectionStart;
        const end = this.element.selectionEnd;
        this.element.setRangeText(text,start,end)

        // blob.signed_idをimagesに関連付ける為の、非表示のフォームを生成。
        const hiddenField = document.createElement('input');
        hiddenField.setAttribute('type', 'hidden');
        hiddenField.setAttribute('name', 'post[images][]');
        hiddenField.setAttribute('value', blob.signed_id);
        this.element.closest('form').appendChild(hiddenField);
      }
    })
  }

  // markdown表示のためのURLを生成
  markdownUrl(blob){
    const filename = blob.filename
    const url = `/rails/active_storage/blobs/${blob.signed_id}/${blob.filename}`;
    const prefix = (this.isImage(blob.content_type) ? '!' : '');

    return `${prefix}[${filename}](${url})\n`;
  }

  // ドロップされたファイルがjpeg、gif、pngかを判定
  isImage(contentType){
    return ["image/jpeg", "image/gif", "image/png"].includes(contentType);
  }

  // ドロップされたファイルの形式を確認するために、判定用のisImageを呼び出す
  isValidFileType(file) {
    return this.isImage(file.type);
  }

  // ドロップされたファイルのサイズが1MBを超えてないか判定
  isValidFileSize(file) {
    const maxSize = 1 * 1024 * 1024;
    return file.size <= maxSize;
  }

  // 非表示フォームの値と、textarea内のblob.signed_idが一致しなくなればフォームを削除する
  monitoringOfMarkdownUrl() {
    const hiddenFields = this.element.closest("form").querySelectorAll('input[type="hidden"][name="post[images][]"]');
    const textareaValue = this.element.value;

    hiddenFields.forEach(field => {
      const signedId = field.value;
      if (!textareaValue.includes(`/rails/active_storage/blobs/${signedId}`)){
        field.remove();
      }
    });
  }
}
