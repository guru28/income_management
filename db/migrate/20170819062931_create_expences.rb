class CreateExpences < ActiveRecord::Migration[5.1]
  def change
    create_table :expences do |t|
      t.string :name
      t.integer :amount
      t.references :user
      t.references :category

      t.timestamps
    end
  end
end
