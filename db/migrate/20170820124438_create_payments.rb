class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.string :name
      t.references :category, foreign_key: true
      t.references :paymentable, polymorphic: true

      t.timestamps
    end
  end
end
