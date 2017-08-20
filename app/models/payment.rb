class Payment < ApplicationRecord
  belongs_to :category, required: false
  belongs_to :paymentable, polymorphic: true


  validates :name,
    presence: {:message => "Please enter Name" }

  validates :amount,
    presence: {:message => "Please enter Amount" }

  validates :category_id,
    presence: {:message => "Please select Category" }
  
end
