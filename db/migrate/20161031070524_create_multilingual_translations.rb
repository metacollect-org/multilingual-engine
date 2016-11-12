class CreateMultilingualTranslations < ActiveRecord::Migration[5.0]
  def change
    create_table :multilingual_translations do |t|
      t.string :content
      t.integer :language_id
      t.references :translatable, polymorphic: true, index: { name: 'index_multilingual_translations_translatable' }
    end
    add_foreign_key :multilingual_translations, :multilingual_languages, column: :language_id
  end
end
