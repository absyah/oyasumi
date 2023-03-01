require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'clock_in!' do
    user.clock_in!
    sleep_records = user.sleep_records.active

    expect(sleep_records.count).to eq(1)
    expect(sleep_records.last.clock_in_at).not_to eq(nil)
    expect(sleep_records.last.clock_out_at).to eq(nil)
  end

  it 'clock_in!' do
    user.clock_in!
    user.clock_out!
    active_sleep_records = user.sleep_records.active
    completed_sleep_records = user.sleep_records.completed

    expect(active_sleep_records.count).to eq(0)
    expect(completed_sleep_records.count).to eq(1)
    expect(completed_sleep_records.last.clock_in_at).not_to eq(nil)
    expect(completed_sleep_records.last.clock_out_at).not_to eq(nil)
  end
end
