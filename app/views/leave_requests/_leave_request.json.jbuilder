json.extract! leave_request, :id, :commence, :end_date, :reason, :approved, :created_at, :updated_at
json.url leave_request_url(leave_request, format: :json)
