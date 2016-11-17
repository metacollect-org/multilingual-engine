FactoryGirl.define do
  factory :multilingual_translation_type, class: 'Multilingual::TranslationType' do
    factory :google do
      uid 'google'
      level 0
    end

    factory :watson do
      uid 'watson'
      level 0
    end

    factory :beginner do
      uid 'beginner'
      level 1
    end

    factory :intermediate do
      uid 'intermediate'
      level 2
    end

    factory :expert do
      uid 'expert'
      level 3
    end
  end
end
