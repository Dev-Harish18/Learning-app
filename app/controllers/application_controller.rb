class ApplicationController < ActionController::API
	rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  	rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  	rescue_from ActiveRecord::InvalidForeignKey, with: :render_not_found_response_invalid_foreign_key



	  def render_unprocessable_entity_response(exception)
	    render json: exception.record.errors, status: :unprocessable_entity
	  end

	  def render_not_found_response_invalid_foreign_key(exception)
	    render json: { error: exception.message }, status: :unprocessable_entity
	  end	  

	  def render_not_found_response(exception)
	    render json: { error: exception.message }, status: :not_found
	  end

	  def throw_error(msg,status)
	  	 render json:msg,status: status
	  end

	  def doorkeeper_unauthorized_render_options(error: nil)
  		 { json: { error: "Unauthorized. Please signin again" } }
	  end

	 private

		def set_current_user
			  @current_user ||= User.find(doorkeeper_token[:resource_owner_id]) if doorkeeper_token
		end
end
