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

      it 'uppercase' do
          lang.code.upcase!
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
    it 'has no language records before creation' do
      expect(Language.count).to eq(0)
    end

    it 'has no translation records before creation' do
      expect(Translation.count).to eq(0)
    end

    it 'has language records after creation' do
      lang  # create object
      expect(Language.count).to eq(lang_count)
    end

    it 'has translation records after creation' do
      lang  # create object
      expect(Translation.count).to eq(trans_count)
    end

    it 'has no language records after destruction' do
      lang.destroy
      expect(Language.count).to eq(0)
    end

    it 'has no translation records after destruction' do
      lang.destroy
      expect(Translation.count).to eq(0)
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

      it '.get_coded returns the right hash' do
        exp = Hash.new
        full.translations.each do |trans|
          exp[trans.language.code] = trans.language
        end
        expect(Language.get_coded).to eq(exp)
      end

      context 'when created' do
        it 'there are 3 language records' do
          full # create object
          expect(Language.count).to eq(3)
        end

        it 'there are 3 translation records' do
          full # create object
          expect(Translation.count).to eq(3)
        end

        it 'has 3 associated translations' do
          expect(full.translations.size).to eq(3)
        end

        it 'its translations always refer to this term' do
          full.translations.each do |trans|
              expect(trans.translatable).to equal(full)
          end
        end

        it 'is available in English, German, and French languages' do
          expect(full.translations.map { |t| t.language.code }.to_set).to eq(['en', 'de', 'fr'].to_set)
        end
      end

      context 'when destroyed' do
        it 'leaves other languages untouched' do
          full.destroy  # destroy object
          expect(Language.count).to eq(2)
        end

        it 'leaves no translation records' do
          full.destroy  # destroy object
          expect(Translation.count).to eq(0)
        end
      end
    end
  end
end
