class User < ApplicationRecord
  has_many :sleep_records, dependent: :destroy

  # these acts_as_* comes from socialization
  acts_as_followable

  acts_as_follower

  def clock_in!
    SleepRecord.clock_in!(self)
  end

  def clock_out!
    SleepRecord.clock_out!(self)
  end
end
