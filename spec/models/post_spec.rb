require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user, name: 'Patrick Harvey', email: 'patrick@example.com') }

  describe '#is_posted_by_user?(user)' do
    context 'post作成者がログインユーザーと等しい場合' do
      let(:post_1) { create(:post, user_id: user_1.id) }

      it 'trueを返す' do
        login_user = User.find(user_1.id)
        expect(post_1.is_posted_by_user?(login_user)).to eq true
      end
    end

    context 'post作成者がログインユーザーと違う場合' do
      let(:post_2) { create(:post, user_id: user_2.id) }

      it 'falseを返す' do
        login_user = User.find(user_1.id)
        expect(post_2.is_posted_by_user?(login_user)).to eq false
      end
    end
  end
end
