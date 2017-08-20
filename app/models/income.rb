class Income < ApplicationRecord
	has_one :payment, as: :paymentable,  dependent: :destroy
end
