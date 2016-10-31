FactoryGirl.define do
  factory :english, class: 'Multilingual::Language' do
    code 'en'
  end
  factory :german, class: 'Multilingual::Language' do
    code 'de'
  end
  factory :french, class: 'Multilingual::Language' do
    code 'fr'
  end
end