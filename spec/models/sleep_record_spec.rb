require 'rails_helper'

RSpec.describe SleepRecord, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'inserts correct sleep duration' do
    duration = 3600
    clocked_in_at = Time.utc(2015, 1, 1, 12, 0, 0)
    clocked_out_at = clocked_in_at + duration.seconds

    Timecop.freeze(clocked_in_at) do
      SleepRecord.clock_in!(user)
    end

    Timecop.freeze(clocked_out_at) do
      SleepRecord.clock_out!(user)
    end

    expect(user.sleep_records.completed.last.sleep_duration).to eq(duration)
  end
end
