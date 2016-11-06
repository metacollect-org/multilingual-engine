require 'rails_helper'

module Multilingual
  shared_examples 'a valid translation' do

    it 'its Factory is valid' do
      expect(trans).to be_valid
    end

    context 'is invalid when' do
      context '@content is' do
        it 'missing' do
          trans.content = nil
          expect(trans).not_to be_valid
        end

        it 'empty' do
          trans.content = ''
          expect(trans).not_to be_valid
        end
      end

      it '@language is not present' do
          trans.language = nil
          expect(trans).not_to be_valid
      end

      it '@translateable is not present' do
          trans.translateable = nil
          expect(trans).not_to be_valid
      end
    end

    it 'its @content matches' do
      expect(trans.content).to eq(content)
    end

    context 'when referring to the associations' do
      it '@translateable matches' do
        expect(trans.translateable.code).to eq(term_code)
      end

      it '@language matches' do
        expect(trans.language.code).to eq(lang_code)
      end
    end
  end

  RSpec.describe Translation, type: :model do
    context "the term 'English'" do
        context 'when in English' do
          it_behaves_like 'a valid translation' do
              let(:trans) { FactoryGirl.create(:en2en_stubbed_translation) }
              let(:content) { 'English' }
              let(:term_code) { 'en' }
              let(:lang_code) { 'en' }
          end
        end

        context 'when in German' do
          it_behaves_like 'a valid translation' do
              let(:trans) { FactoryGirl.create(:en2de_stubbed_translation) }
              let(:content) { 'Englisch' }
              let(:term_code) { 'en' }
              let(:lang_code) { 'de' }
          end
        end

        context 'when in French' do
          it_behaves_like 'a valid translation' do
              let(:trans) { FactoryGirl.create(:en2fr_stubbed_translation) }
              let(:content) { 'anglais' }
              let(:term_code) { 'en' }
              let(:lang_code) { 'fr' }
          end
        end
    end
  end
end
