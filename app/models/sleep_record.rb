class SleepRecord < ApplicationRecord
  belongs_to :user

  # active sleep records mean the sleep records that haven't clocked out yet
  scope :active, -> { where.not(clock_in_at: nil).where(clock_out_at: nil).order(:created_at) }

  # completed sleep records mean the sleep records that have completed the lifecycle
  scope :completed, -> { where.not(clock_in_at: nil).where.not(clock_out_at: nil).order(:created_at) }

  # calculates sleep duration before updating the sleep record
  before_update :calculate_sleep_duration

  class << self
    def clock_in!(user)
      user.sleep_records.create(clock_in_at: DateTime.current)
    end

    def clock_out!(user)
      # get the last active sleep record to be proceeded
      sleep_record = user.sleep_records.active.last

      # if user forcefully clock_out, then creates new record then performs a clock_in
      sleep_record ||= clock_in!(user)

      sleep_record.update(clock_out_at: DateTime.current)
      sleep_record
    end
  end

  private

  def calculate_sleep_duration
    self.sleep_duration = clock_out_at.to_i - clock_in_at.to_i
  end
end
