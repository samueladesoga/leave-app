class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  	@leave_requests = current_user.leave_requests.order('created_at DESC')
  end
end
