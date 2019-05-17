require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user, name: 'Patrick Harvey', email: 'patrick@example.com') }
  let(:post_1) { create(:post, user_id: user_1.id) }
  let(:post_2) { create(:post, user_id: user_2.id) }

  describe '#is_commented_by_user?(user)' do
    context 'コメント作成者とログインユーザーが同じ場合' do
      let(:comment_1) { create(:comment, user_id: user_1.id, post_id: post_1.id) }

      it 'コメントの編集ができる' do
        login_user = User.find(user_1.id)
        expect(comment_1.is_commented_by_user?(login_user)).to eq true
      end
    end

    context 'コメント作成者とログインユーザーが違う場合' do
      let(:comment_2) { create(:comment, user_id: user_2.id, post_id: post_2.id) }

      it 'コメントの編集ができない' do
        login_user = User.find(user_1.id)
        expect(comment_2.is_commented_by_user?(login_user)).to eq false
      end
    end
  end

  describe '#is_anonymous?' do
    context 'コメント作成者が匿名ユーザーの場合' do
      let(:comment_3) { create(:comment, user_id: nil, post_id: post_1.id) }

      it 'コメントが匿名である' do
        expect(comment_3.is_anonymous?).to eq true
      end
    end

    context 'コメント作成者が匿名ユーザーではない場合' do
      let(:comment_4) { create(:comment, user_id: user_2.id, post_id: post_1.id) }

      it 'コメントが匿名でない' do
        expect(comment_4.is_anonymous?).to eq false
      end
    end
  end

  describe '#can_be_edited_by_user?(user)' do
    context 'コメント作成者とログインユーザーが同じ場合' do
      let(:comment_5) { create(:comment, user_id: user_1.id, post_id: post_1.id) }

      it 'ログインユーザーがコメントを編集、削除できる' do
        login_user = User.find(user_1.id)
        expect(comment_5.can_be_edited_by_user?(login_user)).to eq true
      end
    end

    context 'コメント作成者とログインユーザーが違う場合' do
      let(:comment_5) { create(:comment, user_id: user_2.id, post_id: post_1.id) }

      it 'ログインユーザーがコメントを編集、削除できない' do
        login_user = User.find(user_1.id)
        expect(comment_5.can_be_edited_by_user?(login_user)).to eq false
      end
    end

    context 'ポスト作成者がログインユーザーと同じ、かつ匿名コメントの場合' do
      let(:comment_5) { create(:comment, user_id: nil, post_id: post_1.id) }

      it 'ログインユーザーがコメントを編集、削除できる' do
        login_user = User.find(user_1.id)
        expect(comment_5.can_be_edited_by_user?(login_user)).to eq true
      end
    end

    context 'ポスト作成者がログインユーザーと違う、かつ匿名コメントではない場合' do
      let(:comment_6) { create(:comment, user_id: nil, post_id: post_2.id) }

      it 'ログインユーザーがコメントを編集、削除できない' do
        login_user = User.find(user_1.id)
        expect(comment_6.can_be_edited_by_user?(login_user)).to eq false
      end
    end
  end
end
