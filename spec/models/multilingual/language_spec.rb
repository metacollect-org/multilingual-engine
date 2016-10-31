require 'rails_helper'

module Multilingual
  RSpec.describe Language, type: :model do
    let(:lang) { FactoryGirl.create :english }

    its(:code) { is_expected.to == 'en' }
  end
end
