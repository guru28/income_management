class CreateExpences < ActiveRecord::Migration[5.1]
  def change
    create_table :expences do |t|
      t.references :user

      t.timestamps
    end
  end
end
