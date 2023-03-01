FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
  end

  factory :active_sleep_record, class: 'SleepRecord' do
    association :user
    clock_in_at { DateTime.current - 2.weeks }
  end

  factory :completed_sleep_record, class: 'SleepRecord' do
    association :user
    clock_in_at { DateTime.current - 2.weeks }
    clock_out_at { DateTime.current - 2.weeks + 1.hour }
    sleep_duration { 3600 }
  end

  factory :past_week_sleep_record, class: 'SleepRecord' do
    association :user
    clock_in_at { DateTime.current - 1.week }
    clock_out_at { DateTime.current - 1.week + 1.hour }
    sleep_duration { 3600 }
  end
end
