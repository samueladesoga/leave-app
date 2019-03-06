class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  	@leave_requests = current_user.leave_requests
  end
end
