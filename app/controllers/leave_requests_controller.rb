class LeaveRequestsController < InheritedResources::Base

  def new
    @leave_request = LeaveRequest.new
  end
  
  def create 
     @leave_request = current_user.leave_requests.build(leave_request_params)
      if @leave_request.save
        flash[:notice] = "Your leave request has been submitted to be approved"
        redirect_to root_url
      else
        flash[:notice] = "There was an error submitting your leave request"
        render :action => :new
      end
  end


  private

    def leave_request_params
      params.require(:leave_request).permit(:commence, :end, :reason)
    end
end

