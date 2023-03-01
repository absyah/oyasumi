require 'rails_helper'

RSpec.describe 'Follows', type: :request do
  let(:current_user) { FactoryBot.create(:user) }
  let(:friend1) { FactoryBot.create(:user) }
  let(:friend2) { FactoryBot.create(:user) }

  before(:each) do
    http_login(current_user)
  end

  describe 'POST /api/v1/users/:id/follow' do
    it 'returns following user' do
      post "/api/v1/users/#{friend1.id}/follow", headers: @env

      expect(response).to have_http_status(:success)
      expect(json['data']['attributes']['id']).to eq(friend1.id)
    end
  end

  describe 'POST /api/v1/users/:id/unfollow' do
    it 'returns unfollowing user' do
      post "/api/v1/users/#{friend2.id}/unfollow", headers: @env

      expect(response).to have_http_status(:success)
      expect(json['data']['attributes']['id']).to eq(friend2.id)
    end
  end
end
