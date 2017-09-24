class Project < ApplicationRecord
	belongs_to :user, required: false
	belongs_to :category, required: false

	scope :ordered_by_title, -> { order(title: :asc) }
end
