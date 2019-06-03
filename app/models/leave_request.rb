class LeaveRequest < ApplicationRecord
	belongs_to :patron
	validates_presence_of :commence, :end_date, :reason

	scope :pending_approval, -> { where(status: 0) }


	enum status: {pending: 0, approved: 1, rejected: 2 } do
	    event :approve do
	      transition [:pending, :rejected] => :approved
	    end

	    event :reject do
	      transition [:pending, :approved] => :rejected
	    end
	end
end
