FactoryGirl.define do
  factory :multilingual_language, class: 'Multilingual::Language' do
    factory :english_language do
      code 'en'
    end

    factory :german_language do
      code 'de'
    end

    factory :french_language do
      code 'fr'
    end
  end
end
