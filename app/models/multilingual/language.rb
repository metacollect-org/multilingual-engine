module Multilingual
  class Language < ApplicationRecord
    has_many :translations, as: :translatable, dependent: :destroy

    validates :code, presence: true,
                     length: { is: 2 },
                     uniqueness: true,
                     format: { with: /[[:lower:]]/,
                       message: 'only allows uppercase letters' }
    validates_associated :translations

    def self.get_coded
      return Hash[Language.all.map { |l| [l.code, l] }]
    end
  end
end
