class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :item_name
      t.float :amount
      t.boolean :sold
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
