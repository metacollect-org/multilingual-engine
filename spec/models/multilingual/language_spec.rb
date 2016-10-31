require 'rails_helper'

module Multilingual
  shared_examples 'a valid language' do |attr|
    let(:lang) { described_class.create(**attr) }

    it 'its Factory is valid' do
      expect(lang).to be_valid
    end

    context 'is invalid when @code is' do
      it 'missing' do
          lang.code = nil
          expect(lang).to_not be_valid
      end

      it 'empty' do
          lang.code = ''
          expect(lang).to_not be_valid
      end

      it 'one-letter long' do
          lang.code = 'a'
          expect(lang).to_not be_valid
      end

      it 'three-letters long' do
          lang.code = 'abc'
          expect(lang).to_not be_valid
      end
    end

    context '@code uniqueness' do
      let(:second) { described_class.create(**attr) }

      it 'record has the given code' do
        expect(lang.code).to eq(attr[:code])
      end

      it 'is violated by another model with the same code' do
        expect(lang).to be_valid
        expect(second).to_not be_valid
      end

      it 'is fulfilled by another model with a different two-letter code' do
        expect(lang).to be_valid
        second.code = 'fu'
        expect(second).to be_valid
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
