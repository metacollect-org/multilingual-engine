require 'rails_helper'

module Multilingual
  RSpec.describe Translation, type: :model do
      let(:trans) { FactoryGirl.create(:english_translation, content: 'snafu') }

      it 'its Factory is valid' do
        expect(trans).to be_valid
      end
  end
end
