module Multilingual
  class Language < ApplicationRecord
    has_many :translations, as: :translateable, dependent: :destroy

    validates :code, presence: true,
                     length: { is: 2 },
                     uniqueness: true
    validates_associated :translations

    def self.get_coded
      return Hash[Language.all.map { |l| [l.code, l] }]
    end
  end
end
