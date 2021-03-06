# frozen_string_literal: true
FactoryGirl.define do
  factory :competition do
    sequence(:name) { |n| "Foo Comp #{n} 2015" }

    cityName "San Francisco"
    countryId "USA"
    information "Information!"
    latitude { rand(-90000000..90000000) }
    longitude { rand(-180000000..180000000) }

    transient do
      starts 1.year.ago
      ends { starts }
    end

    start_date { starts.nil? ? nil : starts.strftime("%F") }
    end_date { ends.nil? ? nil : ends.strftime("%F") }

    trait :future do
      starts 1.week.from_now
    end

    trait :ongoing do
      starts Time.now
    end

    trait :past do
      starts 1.week.ago
    end

    trait :results_posted do
      results_posted_at Time.now
    end

    events { Event.where(id: %w(333 333oh)) }

    venue "My backyard"
    venueAddress "My backyard street"
    external_website "https://www.worldcubeassociation.org"
    showAtAll false
    isConfirmed false

    guests_enabled true

    trait :with_delegate do
      delegates { [ FactoryGirl.create(:delegate) ] }
    end

    trait :with_organizer do
      organizers { [ FactoryGirl.create(:user) ] }
    end

    trait :with_delegate_report do
      after(:create) do |competition|
        FactoryGirl.create :delegate_report, :posted, competition: competition
      end
    end

    use_wca_registration false
    registration_open 2.weeks.ago.change(usec: 0)
    registration_close 1.week.ago.change(usec: 0)

    trait :registration_open do
      use_wca_registration true
      registration_open 2.weeks.ago.change(usec: 0)
      registration_close 2.weeks.from_now.change(usec: 0)
    end

    trait :confirmed do
      with_delegate
      isConfirmed true
    end

    trait :visible do
      with_delegate
      showAtAll true
    end
  end
end
