FactoryGirl.define do
  factory :multilingual_translation, class: 'Multilingual::Translation' do
    trait :english_term do
      association :translatable, factory: :english_language, strategy: :build_stubbed
    end

    trait :en2en do
      content 'English'
    end

    trait :en2de do
      content 'Englisch'
    end

    trait :en2fr do
      content 'anglais'
    end

    trait :en_stubbed_association do
      association :language, factory: :english_language, strategy: :build_stubbed
    end

    trait :de_stubbed_association do
      association :language, factory: :german_language, strategy: :build_stubbed
    end

    trait :fr_stubbed_association do
      association :language, factory: :french_language, strategy: :build_stubbed
    end

    trait :en_association do
      association :language, factory: :english_language
    end

    trait :de_association do
      association :language, factory: :german_language
    end

    trait :fr_association do
      association :language, factory: :french_language
    end

    factory :en2en_stubbed_translation, traits: [:english_term, :en2en, :en_stubbed_association]
    factory :en2de_stubbed_translation, traits: [:english_term, :en2de, :de_stubbed_association]
    factory :en2fr_stubbed_translation, traits: [:english_term, :en2fr, :fr_stubbed_association]

  end
end
