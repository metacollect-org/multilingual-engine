class CreateMultilingualLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :multilingual_languages do |t|
      t.string :code, limit: 2  # ISO 639-1
    end
    add_index :multilingual_languages, :code, unique: true
  end
end
