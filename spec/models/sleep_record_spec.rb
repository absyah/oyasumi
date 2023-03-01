require 'rails_helper'

RSpec.describe SleepRecord, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:active_sleep_record) { FactoryBot.create(:active_sleep_record) }
  let(:completed_sleep_record) { FactoryBot.create(:completed_sleep_record) }
  let(:past_week_sleep_record) { FactoryBot.create(:past_week_sleep_record) }

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

  context 'scopes' do
    it 'returns active sleep records' do
      expect(SleepRecord.active).to eq([active_sleep_record])
    end

    it 'returns completed sleep records' do
      expect(SleepRecord.completed).to eq([completed_sleep_record])
    end

    it 'returns user\' past week sleep records' do
      expect(SleepRecord.past_week([past_week_sleep_record.user_id])).to eq([past_week_sleep_record])
    end
  end
end
