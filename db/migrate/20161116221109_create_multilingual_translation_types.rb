class CreateMultilingualTranslationTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :multilingual_translation_types do |t|
      t.string :uid, unique: true, null: false, limit: 32, index: true  # arbitrary size restriction
      t.integer :level, null: false
    end

    add_column :multilingual_translations, :type_id, :integer
    add_foreign_key :multilingual_translations, :multilingual_translation_types, column: :type_id
  end
end
