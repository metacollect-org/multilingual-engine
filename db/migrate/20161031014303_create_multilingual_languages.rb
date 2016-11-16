class CreateMultilingualLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :multilingual_languages do |t|
      t.string :code, limit: 2, unique: true, null: false  # ISO 639-1
    end
  end
end
