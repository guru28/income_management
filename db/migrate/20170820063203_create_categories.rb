class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string 		:name
      t.integer 	:category_type, default: 0
      t.references 	:user

      t.timestamps
    end
  end
end
