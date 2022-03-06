class Api::V1::TestsController < ApplicationController
	before_action :doorkeeper_authorize!,:set_current_user
	before_action :set_attempt,except:[:start_test]

	def start_test
		#create an attempt
		@attempt=Attempt.create!({
			user_id:@current_user.id,
			exercise_id:start_test_params[:exercise_id]
		})

		#send all the questions
		@questions=Question.where(exercise_id:start_test_params[:exercise_id])

		questions = ActiveModelSerializers::SerializableResource.new(@questions, each_serializer: Api::V1::QuestionSerializer)
		render json:{
				attempt_id:@attempt.id,
				questions:questions
				},
				status: :created
	end

	def answer_question
		#calculate score
		@question=Question.find(answer_question_params[:question_id])
		score = (@question.correct_option == answer_question_params[:submitted_answer])? 1 : 0
		
		#create attempted_questions
		@attempted_question=AttemptedQuestion.create!({
			attempt_id:@attempt.id,
			question_id:answer_question_params[:question_id],
			submitted_answer:answer_question_params[:submitted_answer],
			score:score			
		})
		
		# return "Submitted successfully"
		render json:{
			data:@attempted_question,
			message:"Question answered successfully"	
		},status: :created
	end

	def end_test
		return throw_error("Time spent must be included",:unprocessable_entity) if end_test_params[:time_spent].blank?
		#calculate total score
		records=AttemptedQuestion.where(attempt_id:@attempt.id)
		questions = records.map do |q|
			Question.find(q.question_id)
		end

		total_score=0

		records.each do |ques|
			total_score+=ques.score
		end
		
		#update attempts
		@attempt.update!(time_spent:end_test_params[:time_spent],total_score:total_score)
		
		#return current attempt
		render json:@attempt,questions:questions,records:records,status: :ok
	end

	private
		def set_attempt
			@attempt=Attempt.find(params[:id])
		end	

		def start_test_params
			params.permit(:exercise_id)
		end

		def answer_question_params
			params.permit(:submitted_answer,:question_id)
		end

		def end_test_params
			params.permit(:time_spent)
		end
	
end
