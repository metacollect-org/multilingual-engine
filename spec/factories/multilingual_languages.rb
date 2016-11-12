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
            build_stubbed(:multilingual_translation, :en2en, language: lang, translatable: lang),
            build_stubbed(:multilingual_translation, :en2de, :de_stubbed_association, translatable: lang),
            build_stubbed(:multilingual_translation, :en2en, :fr_stubbed_association, translatable: lang)
        ]
      end

      after(:create) do |lang|
        lang.translations = [
            create(:multilingual_translation, :en2en, language: lang, translatable: lang),
            create(:multilingual_translation, :en2de, :de_association, translatable: lang),
            create(:multilingual_translation, :en2en, :fr_association, translatable: lang)
        ]
      end
    end
  end
end
