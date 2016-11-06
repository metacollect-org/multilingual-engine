require 'rails_helper'
require 'set'

module Multilingual
  shared_examples 'a valid language' do
    it 'its Factory is valid' do
      expect(lang).to be_valid
    end

    context 'is invalid when @code is' do
      it 'missing' do
          lang.code = nil
          expect(lang).not_to be_valid
      end

      it 'empty' do
          lang.code = ''
          expect(lang).not_to be_valid
      end

      it 'one-letter long' do
          lang.code = 'a'
          expect(lang).not_to be_valid
      end

      it 'three-letters long' do
          lang.code = 'abc'
          expect(lang).not_to be_valid
      end
    end

    context '@code uniqueness' do
      it 'record has the given code' do
        expect(lang.code).to eq(code)
      end

      it 'is violated by another model with the same code' do
        expect(lang).to be_valid
        expect(second).not_to be_valid
      end

      it 'is fulfilled by another model with a different two-letter code' do
        expect(lang).to be_valid
        second.code = 'fu'
        expect(second).to be_valid
      end
    end
  end

  shared_examples 'an ActiveRecord with proper CRUD' do
    it 'is correctly created' do
      expect(Multilingual::Language.count).to eq(0)
      expect(Multilingual::Translation.count).to eq(0)
      lang  # create object
      expect(Multilingual::Language.count).to eq(lang_count)
      expect(Multilingual::Translation.count).to eq(trans_count)
    end

    it 'is correctly destroyed' do
      lang  # create object
      expect(Multilingual::Language.count).to eq(lang_count)
      expect(Multilingual::Translation.count).to eq(trans_count)
      lang.destroy
      expect(Multilingual::Language.count).to eq(0)
      expect(Multilingual::Translation.count).to eq(0)
    end
  end

  RSpec.describe Language, type: :model do
    context 'with English' do
      it_behaves_like 'a valid language' do
        let(:lang) { FactoryGirl.create(:english_language) }
        let(:second) { FactoryGirl.build(:english_language) }
        let(:code) { 'en' }
      end

      it_behaves_like 'an ActiveRecord with proper CRUD' do
        let(:lang) { FactoryGirl.create(:english_language) }
        let(:lang_count) { 1 }
        let(:trans_count) { 0 }
      end
    end

    context 'with German' do
      it_behaves_like 'a valid language' do
        let(:lang) { FactoryGirl.create(:german_language) }
        let(:second) { FactoryGirl.build(:german_language) }
        let(:code) { 'de' }
      end

      it_behaves_like 'an ActiveRecord with proper CRUD' do
        let(:lang) { FactoryGirl.create(:german_language) }
        let(:lang_count) { 1 }
        let(:trans_count) { 0 }
      end
    end

    context 'with French' do
      it_behaves_like 'a valid language' do
        let(:lang) { FactoryGirl.create(:french_language) }
        let(:second) { FactoryGirl.build(:french_language) }
        let(:code) { 'fr' }
      end

      it_behaves_like 'an ActiveRecord with proper CRUD' do
        let(:lang) { FactoryGirl.create(:french_language) }
        let(:lang_count) { 1 }
        let(:trans_count) { 0 }
      end
    end

    context 'with English in three languages' do
      let(:full) { FactoryGirl.create(:english_with_translations) }

      it_behaves_like 'a valid language' do
        let(:lang) { full }
        let(:second) { FactoryGirl.build(:english_language) }
        let(:code) { 'en' }
      end

      it_behaves_like 'an ActiveRecord with proper CRUD' do
        let(:lang) { full }
        let(:lang_count) { 1 }
        let(:trans_count) { 3 }
      end

      it 'always refers to the English language' do
        full.translations.each do |trans|
            expect(trans.translateable).to equal(full)
        end
      end

      it 'is available in 3 languages' do
        expect(full.translations.size).to eq(3)
      end

      it 'is available in English, German, and French' do
        expect(full.translations.map { |t| t.language.code }.to_set).to eq(['en', 'de', 'fr'].to_set)
      end

      context 'when destroyed' do
        it 'other languages are untouched' do
          full.translations.each do |trans|
            trans.language =
              case trans.language.code
              when 'de' then FactoryGirl.create(:german_language)
              when 'fr' then FactoryGirl.create(:french_language)
              else full
              end
          end
          expect(Multilingual::Language.count).to eq(3)
          expect(Multilingual::Translation.count).to eq(3)
          full.destroy  # destroy object
          expect(Multilingual::Language.count).to eq(2)
          expect(Multilingual::Translation.count).to eq(0)
        end
      end
    end
  end
end
