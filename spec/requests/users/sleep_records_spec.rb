require 'rails_helper'

RSpec.describe 'SleepRecords', type: :request do
  let(:current_user) { FactoryBot.create(:user) }
  let(:friend1) { FactoryBot.create(:user) }
  let(:friend2) { FactoryBot.create(:user) }

  before(:each) do
    http_login(current_user)
  end

  describe 'GET /api/v1/users/sleep_records' do
    before do
      current_user.follow!(friend1)

      Timecop.freeze(DateTime.current - 1.week) do
        5.times do
          friend1.clock_out!
          friend2.clock_out!
        end
      end

      Timecop.freeze(DateTime.current - 2.weeks) do
        5.times do
          friend1.clock_out!
        end
      end
    end

    it 'returns followees\' past week sleep records' do
      get "/api/v1/users/sleep_records", headers: @env

      expect(response).to have_http_status(:success)
      expect(json['data'].length).to eq(5)
      json['data'].each do |record|
        expect(record['attributes']['user_id']).to eq(friend1.id)
      end
    end
  end
end
