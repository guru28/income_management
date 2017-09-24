class Category < ApplicationRecord

	validates :name,
    	presence: true

    validates :name, 
    :format => { 
      :with => /\A[a-zA-Z ]+\z/,
      :message => "should contain alphabets only" 
    }

    has_many :projects
end
