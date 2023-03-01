class User < ApplicationRecord
  has_many :sleep_records, dependent: :destroy

  def clock_in!
    SleepRecord.clock_in!(self)
  end

  def clock_out!
    SleepRecord.clock_out!(self)
  end
end
