class Expence < ApplicationRecord
	has_one :payment, as: :paymentable
end
