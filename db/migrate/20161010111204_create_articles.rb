class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :content
      t.string :tags
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
