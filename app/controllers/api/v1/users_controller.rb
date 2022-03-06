class Api::V1::UsersController < ApplicationController

	before_action :doorkeeper_authorize!,:set_current_user,only:[:get_profile,:update_profile,:enroll_user,:signout]
	


	def signup	
		@user = User.new(user_params)

		if @user.save
			auth_token = create_token
			render json:@user,token:auth_token,status: :created
		else
			render json:{errors:@user.errors},status: :unprocessable_entity
		end
	end

	def signin

		return throw_error("Email or Password is missing.", :unprocessable_entity) if user_params[:email].blank? or user_params[:password].blank?

		@user=User.find_by(email:user_params[:email])
		
		if @user.blank? or @user.authenticate(user_params[:password]) == false
			return throw_error("Email or Password is incorrect.", :unprocessable_entity)
		end

		auth_token = create_token
		render json:@user,token:auth_token,status: :created
		
	end

	def signout
		if request.headers['Authorization'].present?
			token_string = request.headers['Authorization'].split(' ').last
			token = Doorkeeper::AccessToken.find_by("resource_owner_id = ? AND token = ?", @current_user.id, token_string)
			token.revoke
			return render json:{status:"success",message:"Signout successful"},status: :ok
		end
			throw_error("You are logged in",:bad_request)
	end

	def get_profile
		render json:@current_user,status: :ok
	end

	def update_profile
		@current_user.update!(profile_params)
		render json:@current_user,status: :ok
	end
	
	def enroll_user
		@current_user.update!(enroll_params)
		render json:@current_user,status: :ok
	end
	

	private

	def enroll_params
		params.permit(:board_id,:grade_id)
	end

	def user_params
		params.permit(:name,:email,:password,:password_confirmation,:dob,:mobile)
	end

	def profile_params
		params.permit(:name,:email,:dob,:mobile,:board_id,:grade_id)
	end

	def create_token
		access_token = Doorkeeper::AccessToken.create!(
					  resource_owner_id: @user.id,
					  scopes:'student',
					  expires_in: 21.days,
					  )

		auth_token={
		   access_token: access_token.token,
		   token_type: 'bearer',
		   expires_in: access_token.expires_in,
		   created_at: access_token.created_at.to_time.to_i
		}

		return auth_token
	end
end
