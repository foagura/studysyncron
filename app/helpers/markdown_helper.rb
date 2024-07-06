module MarkdownHelper
  def markdown(text)
    render_options = {
      filter_html:         true, # ユーザーが入力したhtmlを出力しない
      hard_wrap:           true, # 改行をhtmlの<br>に置き換え
      space_after_headers: true,  # ヘッダー記号(#)と文字の間にスペース必要
      link_attributes: { rel: 'nofollow', taget: '_blank' }
    }

    extensions = {
      no_intra_emphasis: true,
      tables: true,
      autolink: true,
      lax_spacing: true,
      quote: true,
      fenced_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(render_options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe
  end
end