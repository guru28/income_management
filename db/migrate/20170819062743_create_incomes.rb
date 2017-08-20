class CreateIncomes < ActiveRecord::Migration[5.1]
  def change
    create_table :incomes do |t|
      t.string :name
      t.integer :amount
      t.references :user
      t.references :category

      t.timestamps
    end
  end
end
	