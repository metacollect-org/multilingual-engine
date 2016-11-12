FactoryGirl.define do
  factory :multilingual_language, class: 'Multilingual::Language' do
    trait :english_code do
      code 'en'
    end

    trait :german_code do
      code 'de'
    end

    trait :french_code do
      code 'fr'
    end

    factory :english_language, traits: [:english_code]
    factory :german_language, traits: [:german_code]
    factory :french_language, traits: [:french_code]

    factory :english_with_translations do
      english_code

      after(:stub) do |lang|
        lang.translations = [
            build_stubbed(:multilingual_translation, :en2en, language: lang, translateable: lang),
            build_stubbed(:multilingual_translation, :en2de, :de_stubbed_association, translateable: lang),
            build_stubbed(:multilingual_translation, :en2en, :fr_stubbed_association, translateable: lang)
        ]
      end

      after(:create) do |lang|
        lang.translations = [
            create(:multilingual_translation, :en2en, language: lang, translateable: lang),
            create(:multilingual_translation, :en2de, :de_association, translateable: lang),
            create(:multilingual_translation, :en2en, :fr_association, translateable: lang)
        ]
      end
    end
  end
end
