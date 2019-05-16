require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#is_created_by_user?(user)' do
    context 'user作成者がログインユーザーと等しい場合' do
      let(:user_1) { create(:user) }

      it 'trueを返す' do
        login_user = User.find(user_1.id)
        expect(user_1.is_created_by_user?(login_user)).to eq true
      end
    end

    context 'user作成者がログインユーザーと違う場合' do
      let(:user_1) { create(:user) }
      let(:user_2) { create(:user, name: 'Patrick Harvey', email: 'patrick@example.com') }

      it 'falseを返す' do
        login_user = User.find(user_1.id)
        expect(user_2.is_created_by_user?(login_user)).to eq false
      end
    end
  end
end
