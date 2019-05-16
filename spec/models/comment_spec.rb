require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user, name: 'Patrick Harvey', email: 'patrick@example.com') }
  let(:post_1) { create(:post, user_id: user_1.id) }
  let(:post_2) { create(:post, user_id: user_2.id) }

  describe '#is_commented_by_user?(user)' do
    context 'comment作成者がログインユーザーと等しい場合' do
      let(:comment_1) { create(:comment, user_id: user_1.id, post_id: post_1.id) }

      it 'trueを返す' do
        login_user = User.find(user_1.id)
        expect(comment_1.is_commented_by_user?(login_user)).to eq true
      end
    end

    context 'comment作成者がログインユーザーと違う場合' do
      let(:comment_2) { create(:comment, user_id: user_2.id, post_id: post_2.id) }

      it 'falseを返す' do
        login_user = User.find(user_1.id)
        expect(comment_2.is_commented_by_user?(login_user)).to eq false
      end
    end
  end

  describe '#is_anonymous?' do
    context 'comment作成者が匿名ユーザー場合' do
      let(:comment_3) { create(:comment, user_id: nil, post_id: post_1.id) }

      it 'commentのuser_idがnil' do
        expect(comment_3.is_anonymous?).to eq true
      end
    end
  end

  describe '#can_be_edited_by_user?(user)' do
    context '#is_commented_by_user?(user)がtrueの場合' do
      it 'trueを返す' do
        true
      end
    end

    context '#is_commented_by_user?(user)がfalseの場合' do
      let(:comment_4) { create(:comment, user_id: nil, post_id: post_1.id) }
      let(:comment_5) { create(:comment, user_id: user_1.id, post_id: post_1.id) }

      it 'post.is_posted_by_user?(user) && is_anonymous?がtrue' do
        login_user = User.find(user_1.id)
        expect(post_1.is_posted_by_user?(login_user) && comment_4.is_anonymous?).to eq true
      end

      it 'post.is_posted_by_user?(user) && is_anonymous?がfalse' do
        login_user = User.find(user_1.id)
        expect(post_2.is_posted_by_user?(login_user) && comment_5.is_anonymous?).to eq false
      end
    end
  end
end
