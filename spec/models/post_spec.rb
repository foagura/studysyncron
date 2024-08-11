require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe '学習記録の新規投稿' do
    context '新規投稿できる場合' do
      it 'title、content、study_hours、study_minutes、start_timeの値が存在していれば登録できる' do
        expect(@post).to be_valid
      end
    end

    context '新規投稿できない場合' do
      it 'titleが空だと登録できない' do
        @post.title = ""
        @post.valid?
        expect(@post.errors.full_messages).to include("タイトルが入力されていません。")
      end
    end
  end
end
