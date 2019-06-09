class LeaveRequest < ApplicationRecord
	belongs_to :patron
	validates_presence_of :commence, :end_date, :reason

	scope :pending_approval, -> { where(status: 0) }


	enum status: {pending: 0, approved: 1, rejected: 2 } do
	    event :approve do
  		after do
        	LeaveMailer.notify_user(self.patron.id, self.id).deliver_later
      	end
	      transition [:pending, :rejected] => :approved
	    end

	    event :reject do
  		after do
        	LeaveMailer.notify_user(self.patron.id, self.id).deliver_later
      	end
	      transition [:pending, :approved] => :rejected
	    end
	end
end
