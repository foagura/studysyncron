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
      it 'userに紐づいていないと登録できない' do
        @post.user = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Userを入力してください")
      end
      it 'titleが空だと登録できない' do
        @post.title = ""
        @post.valid?
        expect(@post.errors.full_messages).to include("タイトルが入力されていません。")
      end
      it 'contentが空だと登録できない' do
        @post.content = ""
        @post.valid?
        expect(@post.errors.full_messages).to include("内容が入力されていません。")
      end
      it 'start_timeが空だと登録できない' do
        @post.start_time = ""
        @post.valid?
        expect(@post.errors.full_messages).to include("登録時刻が入力されていません。")
      end
      it 'study_hoursが空だと登録できない' do
        @post.study_hours = ""
        @post.valid?
        expect(@post.errors.full_messages).to include("学習時間(時間)が入力されていません。")
      end
      it 'study_minutesが空だと登録できない' do
        @post.study_minutes = ""
        @post.valid?
        expect(@post.errors.full_messages).to include("学習時間(分)が入力されていません。")
      end
      it 'study_hoursが数字以外だと登録できない' do
        @post.study_hours = "テスト"
        @post.valid?
        expect(@post.errors.full_messages).to include("学習時間(時間)は数値で入力してください")
      end
      it 'study_minutesが数字以外だと登録できない' do
        @post.study_minutes = "テスト"
        @post.valid?
        expect(@post.errors.full_messages).to include("学習時間(分)は数値で入力してください")
      end
      it 'study_hoursが0~23以外の数字だと登録できない' do
        @post.study_hours = 100
        @post.valid?
        expect(@post.errors.full_messages).to include("学習時間(時間)は0..23の範囲に含めてください")
      end
      it 'study_minutesが0~59以外の数字だと登録できない' do
        @post.study_minutes = 100
        @post.valid?
        expect(@post.errors.full_messages).to include("学習時間(分)は0..59の範囲に含めてください")
      end
    end
  end
end
