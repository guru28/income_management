class Payment < ApplicationRecord
  belongs_to :category, required: false
  belongs_to :paymentable, polymorphic: true

end
