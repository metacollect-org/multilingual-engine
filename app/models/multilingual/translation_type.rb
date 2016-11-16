module Multilingual
  class TranslationType < ApplicationRecord
    validates :uid, presence: true,
                     length: { within: 3..32 },
                     uniqueness: true,
                     format: { with: /[[:lower:]]/,
                       message: 'only allows lowercase letters' }
  end
end
