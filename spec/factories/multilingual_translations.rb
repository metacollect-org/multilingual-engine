FactoryGirl.define do
  factory :multilingual_translation, class: 'Multilingual::Translation' do
    factory :en2en_translation do
      content 'English'
    end

    factory :en2de_translation do
      content 'Englisch'
    end

    factory :en2fr_translation do
      content 'anglais'
    end
  end
end
