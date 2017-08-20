class Category < ApplicationRecord
	enum category_type: [:income, :expence]
end
