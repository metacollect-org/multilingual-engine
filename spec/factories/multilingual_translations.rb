FactoryGirl.define do
  factory :empty_translation, class: 'Multilingual::Translation' do
    content nil
    language nil
    translateable nil
  end

  factory :english_translation, parent: :empty_translation,
      class: 'Multilingual::Translation' do
    english
  end
end
