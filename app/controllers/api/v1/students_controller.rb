class Api::V1::StudentsController < ApplicationController

	before_action :doorkeeper_authorize!,:set_current_user,:set_content,only:[:get_content,:update_content]

	def get_boards
		@boards=Board.all
		boards=ActiveModelSerializers::SerializableResource.new(@boards, each_serializer: Api::V1::BoardSerializer)
		render json:{boards:boards},status: :ok
	end

	def get_board
		@board=Board.find(params[:id])
		render json:@board,status: :ok
	end

	def get_grade
		@grade=Grade.find(params[:id])
		render json:@grade,status: :ok
	end

	def get_subject
		@subject=Subject.find(params[:id])
		render json:@subject,status: :ok
	end

	def get_chapter
		@chapter=Chapter.find(params[:id])
		render json:@chapter,status: :ok
	end

	def get_exercise
		@exercise=Exercise.find(params[:id])
		render json:@exercise,status: :ok
	end

	def get_question
		@question=Question.find(params[:id])
		render json:@question,status: :ok
	end

	def get_content
		
		@current_user_content=UserContent.find_by(content_id:@content.id,user_id:@current_user.id)

		current_user_data=(@current_user_content.blank?)?{upvoted:false,downvoted:false,notes:"Sample"}:@current_user_content


		@upvotes=UserContent.where(content_id:@content.id,upvoted:true).count
		@downvotes=UserContent.where(content_id:@content.id,downvoted:true).count
		
		render json:@content,
		upvotes:@upvotes,
		downvotes:@downvotes,
		user_content:current_user_data,
		status: :ok

	end

	def update_content
		
		if (content_params[:upvoted]=="true" && content_params[:downvoted]=="true")
			return throw_error("Upvote and downvote cannot be done at the same time",:unprocessable_entity)
		end

		data = content_params
		
		 
		data[:downvoted]=false if content_params[:upvoted]=="true"
		data[:upvoted]=false if content_params[:downvoted]=="true"


		@user_content=UserContent.find_by(content_id:@content.id,user_id:@current_user.id)

		if @user_content.blank?
			data[:content_id]=@content.id
			data[:user_id]=@current_user.id

			@user_content = UserContent.new(data)
			@user_content.save	
		else
			@user_content.update!(data)	
		end
		
		@upvotes=UserContent.where(content_id:@content.id,upvoted:true).count
		@downvotes=UserContent.where(content_id:@content.id,downvoted:true).count
		
		render json:@user_content,
		upvotes:@upvotes,downvotes:@downvotes,user_content:@user_content,
		status: :ok

	end


	private
	def set_content
		@content=Content.find(params[:id])
	end
	def content_params
		params.permit(:upvoted,:downvoted,:notes)
	end

end