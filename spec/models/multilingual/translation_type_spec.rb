require 'rails_helper'

module Multilingual
  shared_examples 'a valid translation type' do

    it 'its Factory is valid' do
      expect(trans).to be_valid
    end

    context 'is invalid when' do
      context '@uid is' do
        it 'nil' do
          trans.uid = nil
          expect(trans).not_to be_valid
        end

        it 'empty' do
          trans.uid = ''
          expect(trans).not_to be_valid
        end

        it 'too short' do
          trans.uid = 'ab'
          expect(trans).not_to be_valid
        end

        it 'too long' do
          trans.uid = 'a' * 33
          expect(trans).not_to be_valid
        end

        it 'uppercase' do
          trans.uid.upcase!
          expect(trans).not_to be_valid
        end

        it 'uppercase' do
          trans.uid.upcase!
          expect(trans).not_to be_valid
        end
      end

      context '@level is' do
        it 'nil' do
          trans.level = nil
          expect(trans).not_to be_valid
        end

        it 'a string' do
          trans.level = 'woeisme'
          expect(trans).not_to be_valid
        end

        it 'a float' do
          trans.level = 1.1
          expect(trans).not_to be_valid
        end
      end
    end

    context '@uid uniqueness' do
      it 'record has the given @uid' do
        expect(trans.uid).to eq(uid)
      end

      it 'is violated by another model with the same @uid' do
        expect(trans).to be_valid
        expect(second).not_to be_valid
      end

      it 'is fulfilled by another model with a different @uid' do
        expect(trans).to be_valid
        second.uid = 'snafu'
        expect(second).to be_valid
      end
    end
  end

  shared_examples 'an ActiveRecord with proper CRUD' do
    it 'has no records before creation' do
      expect(TranslationType.count).to eq(0)
    end

    it 'has records after creation' do
      trans  # create object
      expect(TranslationType.count).to eq(trans_count)
    end

    it 'has no records after destruction' do
      trans.destroy
      expect(TranslationType.count).to eq(0)
    end
  end

  RSpec.describe TranslationType, type: :model do
    context 'automatic translation' do
      context 'by google' do
        it_behaves_like 'a valid translation type' do
          let(:trans) { FactoryGirl.create(:google) }
          let(:second) { FactoryGirl.build(:google) }
          let(:uid) { 'google' }
        end

        it_behaves_like 'an ActiveRecord with proper CRUD' do
          let(:trans) { FactoryGirl.create(:google) }
          let(:trans_count) { 1 }
        end
      end

      context 'by watson' do
        it_behaves_like 'a valid translation type' do
          let(:trans) { FactoryGirl.create(:watson) }
          let(:second) { FactoryGirl.build(:watson) }
          let(:uid) { 'watson' }
        end

        it_behaves_like 'an ActiveRecord with proper CRUD' do
          let(:trans) { FactoryGirl.create(:watson) }
          let(:trans_count) { 1 }
        end
      end
    end

    context 'manual translation' do
      context 'by a beginner' do
        it_behaves_like 'a valid translation type' do
          let(:trans) { FactoryGirl.create(:beginner) }
          let(:second) { FactoryGirl.build(:beginner) }
          let(:uid) { 'beginner' }
        end

        it_behaves_like 'an ActiveRecord with proper CRUD' do
          let(:trans) { FactoryGirl.create(:beginner) }
          let(:trans_count) { 1 }
        end
      end

      context 'by an intermediate' do
        it_behaves_like 'a valid translation type' do
          let(:trans) { FactoryGirl.create(:intermediate) }
          let(:second) { FactoryGirl.build(:intermediate) }
          let(:uid) { 'intermediate' }
        end

        it_behaves_like 'an ActiveRecord with proper CRUD' do
          let(:trans) { FactoryGirl.create(:intermediate) }
          let(:trans_count) { 1 }
        end
      end

      context 'by an expert' do
        it_behaves_like 'a valid translation type' do
          let(:trans) { FactoryGirl.create(:expert) }
          let(:second) { FactoryGirl.build(:expert) }
          let(:uid) { 'expert' }
        end

        it_behaves_like 'an ActiveRecord with proper CRUD' do
          let(:trans) { FactoryGirl.create(:expert) }
          let(:trans_count) { 1 }
        end
      end
    end
  end
end
