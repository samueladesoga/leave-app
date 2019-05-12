class LeaveRequest < ApplicationRecord
	belongs_to :patron
	validates_presence_of :commence, :end_date, :reason

	scope :pending_approval, -> { where(approved: false) }
end
