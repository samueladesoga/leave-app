class LeaveRequestsController < InheritedResources::Base


  private

    def leave_request_params
      params.require(:leave_request).permit(:commence, :end, :reason, :status)
    end
end

