require 'rails_helper'

module Multilingual
  shared_examples 'a valid language' do |attr|
    let(:lang) { described_class.create(**attr) }

    it 'has a valid factory' do
      expect(lang).to be_valid
    end

    context 'when validating @code' do
      it 'is invalid without a code' do
          lang.code = nil
          expect(lang).to_not be_valid
      end

      it 'is invalid with an empty code' do
          lang.code = ''
          expect(lang).to_not be_valid
      end

      it 'is invalid with a one-letter code' do
          lang.code = 'a'
          expect(lang).to_not be_valid
      end

      it 'is invalid with a three-letter code' do
          lang.code = 'abc'
          expect(lang).to_not be_valid
      end

      it 'is invalid without a unique code' do
          expect(lang.code).to eq(attr[:code])
          second = described_class.create(**attr)
          expect(second).to_not be_valid
      end

      it 'is valid with a unique two-letter code' do
          lang.code = 'fu'
          expect(lang).to be_valid
      end
    end
  end

  RSpec.describe Language, type: :model do
    context 'English' do
      it_behaves_like 'a valid language', FactoryGirl.attributes_for(:english)
    end
    context 'German' do
      it_behaves_like 'a valid language', FactoryGirl.attributes_for(:german)
    end
    context 'French' do
      it_behaves_like 'a valid language', FactoryGirl.attributes_for(:french)
    end
  end
end
