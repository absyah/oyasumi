require 'rails_helper'

RSpec.describe 'SleepRecords', type: :request do
  before(:each) do
    user = FactoryBot.create(:user)
    http_login(user)
  end

  describe 'POST /api/v1/clock_in' do
    it 'returns sleep record with correct clock in' do
      freezed_time = Time.utc(2015, 1, 1, 12, 0, 0)
      Timecop.freeze(freezed_time) do
        post '/api/v1/clock_in', headers: @env
        expect(response).to have_http_status(:success)
        expect(DateTime.parse(json['data']['attributes']['clock_in_at'])).to eq(freezed_time)
      end
    end
  end

  describe 'POST /api/v1/clock_out' do
    it 'returns sleep record with correct clock out' do
      freezed_time = Time.utc(2015, 1, 1, 12, 0, 0)
      Timecop.freeze(freezed_time) do
        post '/api/v1/clock_out', headers: @env
        expect(response).to have_http_status(:success)
        expect(DateTime.parse(json['data']['attributes']['clock_out_at'])).to eq(freezed_time)
      end
    end
  end

  describe 'GET /api/v1/sleep_records' do
    before do
      user = FactoryBot.create(:user)
      10.times do
        user.clock_in!
        user.clock_out!
      end

      5.times do
        user.clock_in!
      end

      http_login(user)
    end

    it 'returns completed sleep records' do
      get '/api/v1/sleep_records', headers: @env
      expect(response).to have_http_status(:success)
      expect(json['data'].length).to eq(10)
    end
  end
end
