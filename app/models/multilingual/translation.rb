module Multilingual
  class Translation < ApplicationRecord
    belongs_to :translatable, polymorphic: true
    belongs_to :language, class_name: 'Language'

    validates :content, presence: true
    validates :language, presence: true
    validates :translatable, presence: true
  end
end
