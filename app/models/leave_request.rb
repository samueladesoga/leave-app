class LeaveRequest < ApplicationRecord
	belongs_to :patron
	validates_presence_of :commence, :end_date, :reason
end
