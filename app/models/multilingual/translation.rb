module Multilingual
  class Translation < ApplicationRecord
    belongs_to :translateable, polymorphic: true
    belongs_to :language, class_name: 'Language'

    validates :content, presence: true
    validates :language, presence: true
  end
end
