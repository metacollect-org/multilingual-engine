module Multilingual
  class Language < ApplicationRecord
    validates :code, presence: true,
                     length: { is: 2 },
                     uniqueness: true
  end
end
