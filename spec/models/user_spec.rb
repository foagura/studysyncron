require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nickname、email、password、password_confirmationの値が存在していれば登録できる' do
        expect(@user).to be_valid
      end
      it 'imageは存在しなくても登録できる' do
        @user.image = nil
        expect(@user).to be_valid
      end
      it 'profileは存在しなくても登録できる' do
        @user.profile = ''
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームが入力されていません。")
      end
      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスが入力されていません。")
      end
      it 'emailが重複していると登録できない' do
        user2 = FactoryBot.create(:user)
        @user.email = user2.email
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは既に使用されています。")
      end
      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは有効でありません。")
      end
      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードが入力されていません。")
      end
      it 'passwordが全角だと登録できない' do
        @user.password = 'ＴＥＳＴ１２'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには半角の英語と数字両方を含めてください")
      end
      it 'passwordが英語のみでは登録できない' do
        @user.password = 'testpw'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには半角の英語と数字両方を含めてください")
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには半角の英語と数字両方を含めてください")
      end
      it 'passwordが5文字以内だと登録できない' do
        @user.password = 'test1'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上に設定して下さい。")
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 130)
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは128文字以下に設定して下さい。")
      end
      it 'passwordとpassword_confirmationが一致していないと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード(確認)が内容とあっていません。")
      end
    end
  end
end
