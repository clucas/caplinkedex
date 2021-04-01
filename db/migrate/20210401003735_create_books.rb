class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.string :published_on
      t.float :unit_cost
      t.string :category
      t.string :currency

      t.timestamps
    end
    add_index :books, [:title, :author, :publisher, :published_on], name: "books_unique_index", unique: true
  end
end
