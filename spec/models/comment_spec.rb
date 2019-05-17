require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user, name: 'Patrick Harvey', email: 'patrick@example.com') }
  let(:post_1) { create(:post, user_id: user_1.id) }
  let(:post_2) { create(:post, user_id: user_2.id) }

  describe '#is_commented_by_user?(user)' do
    context 'コメントを作成したユーザーとログインユーザーが同じ場合' do
      let(:comment_1) { create(:comment, user_id: user_1.id, post_id: post_1.id) }

      it 'trueを返す' do
        login_user = User.find(user_1.id)
        expect(comment_1.is_commented_by_user?(login_user)).to eq true
      end
    end

    context 'コメントを作成したユーザーとログインユーザーが違う場合' do
      let(:comment_2) { create(:comment, user_id: user_2.id, post_id: post_2.id) }

      it 'falseを返す' do
        login_user = User.find(user_1.id)
        expect(comment_2.is_commented_by_user?(login_user)).to eq false
      end
    end
  end

  describe '#is_anonymous?' do
    context 'comment作成者が匿名ユーザーの場合' do
      let(:comment_3) { create(:comment, user_id: nil, post_id: post_1.id) }

      it 'commentが匿名である' do
        expect(comment_3.is_anonymous?).to eq true
      end
    end

    context 'comment作成者が匿名ユーザーではない場合' do
      let(:comment_4) { create(:comment, user_id: user_2.id, post_id: post_1.id) }

      it 'commentが匿名でない' do
        expect(comment_4.is_anonymous?).to eq false
      end
    end
  end

  describe '#can_be_edited_by_user?(user)' do
    context 'ログインユーザーがコメントを編集できる場合' do
      let(:comment_5) { create(:comment, user_id: nil, post_id: post_1.id) }

      it 'trueを返す' do
        login_user = User.find(user_1.id)
        expect(comment_5.can_be_edited_by_user?(login_user)).to eq true
      end
    end

    context 'ログインユーザがコメントを編集できない場合' do
      let(:comment_6) { create(:comment, user_id: nil, post_id: post_2.id) }

      it 'falseを返す' do
        login_user = User.find(user_1.id)
        expect(comment_6.can_be_edited_by_user?(login_user)).to eq false
      end
    end
  end
end
