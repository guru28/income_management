class Category < ApplicationRecord
	enum category_type: [:income, :expence]

	validates :name,
    	presence: true

    validates :name, 
    :format => { 
      :with => /\A[a-zA-Z ]+\z/,
      :message => "should contain alphabets only" 
    }


end
