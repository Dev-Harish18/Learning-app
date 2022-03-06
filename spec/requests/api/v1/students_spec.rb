require 'rails_helper'

RSpec.describe "Api::V1::Students", type: :request do

	before(:all) do 
		5.times do |i|
			create(:board)
			create(:grade,board_id:1)	
			create(:subject,grade_id:1)
			create(:chapter,subject_id:1)
			create(:exercise,chapter_id:1)
			create(:question,exercise_id:1)
			create(:content,chapter_id:1)
		end
	end
		
	describe "Get Boards" do
		before do 
			get "/api/v1/boards"
		end

		it "Fetched Boards" do
			# raise response.body
			expect(json).to_not be_empty
			expect(json['boards'].size).to eq(5)
			expect(response).to have_http_status(:ok)
		end
	end
# -------------------------------------------------------------------------------------
	describe "Get Board" do

		it "Fetched Board" do
			get "/api/v1/boards/1"
			
			expect(json).to_not be_empty
			expect(response).to have_http_status(:ok)
			expect(json['grades'].size).to eq(5)
			expect(json['id']).to eq(1)
		end

		it "Can't fetch board since invalid board id" do
			get "/api/v1/boards/12"

			expect(response).to have_http_status(:not_found)
		end
	end

# ----------------------------------------------------------------------------------------
	describe "Get Grade" do

		it "Fetched Grade" do
			get "/api/v1/grades/1"
			
			# raise response.body
			expect(json).to_not be_empty
			expect(json['subjects'].size).to eq(5)
			expect(response).to have_http_status(:ok)
			expect(json['id']).to eq(1)
		end

		it "Can't fetch board since invalid grade id" do
			get "/api/v1/grades/12"

			expect(response).to have_http_status(:not_found)
		end
	end
# --------------------------------------------------------------------------------------
	describe "Get Subject" do

		it "Fetched Subject" do
			get "/api/v1/subjects/1"
			
			# raise response.body
			expect(json).to_not be_empty
			expect(json['chapters'].size).to eq(5)
			expect(response).to have_http_status(:ok)
			expect(json['id']).to eq(1)
		end

		it "Can't fetch board since invalid board id" do
			get "/api/v1/subjects/12"

			expect(response).to have_http_status(:not_found)
		end
	end
# --------------------------------------------------------------------------------------
	describe "Get Chapter" do

			it "Fetched chapter" do
				get "/api/v1/chapters/1"
				
				# raise response.body
				expect(json).to_not be_empty
				expect(json['exercises'].size).to eq(5)
				expect(response).to have_http_status(:ok)
				expect(json['id']).to eq(1)
			end

			it "Can't fetch board since invalid board id" do
				get "/api/v1/chapters/12"

				expect(response).to have_http_status(:not_found)
			end
		end
# --------------------------------------------------------------------------------------
	describe "Get Exercise" do

			it "Fetched Exercise" do
				get "/api/v1/exercises/1"
				
				# raise response.body
				expect(json).to_not be_empty
				expect(json['questions'].size).to eq(5)
				expect(response).to have_http_status(:ok)
				expect(json['id']).to eq(1)
			end

			it "Can't fetch board since invalid board id" do
				get "/api/v1/exercises/12"

				expect(response).to have_http_status(:not_found)
			end
		end
# --------------------------------------------------------------------------------------
	describe "Get Question" do

			it "Fetched Question" do
				get "/api/v1/questions/1"
				
				# raise response.body
				expect(json).to_not be_empty
				expect(json['option1']).to_not be_empty
				expect(response).to have_http_status(:ok)
				expect(json['id']).to eq(1)
			end

			it "Can't fetch board since invalid board id" do
				get "/api/v1/questions/12"

				expect(response).to have_http_status(:not_found)
			end
	end
# --------------------------------------------------------------------------------------
	describe "Get Content" do
			token=""
			before(:all) do
				
			        post "/api/v1/auth/signup",params:{
			          name:"Harish",
			          email:"hari@gmail.com",
			          mobile:"9807654321",
			          dob:"2021-03-01",
			          password:"pass1234",
			          password_confirmation:"pass1234"
			        }
			        # raise response.body
			        token = JSON.parse(response.body)['auth_token']['access_token']
			end
# --------------------------------------------------
			it "Fetched Content" do
				create(:user_content,user_id:1,content_id:1)
				get "/api/v1/contents/1", params: {}, headers: {'Authorization':"Bearer #{token}"}
				
				expect(json).to_not be_empty
				expect(response).to have_http_status(:ok)
			end
# --------------------------------------------------
			it "Can't fetch board since invalid board id" do
				get "/api/v1/contents/12", params: {}, headers: {'Authorization':"Bearer #{token}"}

				expect(response).to have_http_status(:not_found)
			end
	end
# --------------------------------------------------------------------------------------
	describe "Update Content" do
			token=""
			before(:all) do
				
			        post "/api/v1/auth/signup",params:{
			          name:"Harish",
			          email:"har@gmail.com",
			          mobile:"9907654321",
			          dob:"2021-03-01",
			          password:"pass1234",
			          password_confirmation:"pass1234"
			        }
			        # raise response.body
			        token = JSON.parse(response.body)['auth_token']['access_token']
			        # raise response.body
			end
# ---------------------------------------
			it "Upvoted" do
				put "/api/v1/contents/1",
				 params: {upvoted:true,notes:"Upvoted"},
				 headers: {'Authorization':"Bearer #{token}"}
				
				# raise response.body
				expect(json).to_not be_empty
				expect(json['notes']).to eq("Upvoted")

				expect(response).to have_http_status(:ok)
			end
# ----------------------------------------
			it "Downvoted" do
				put "/api/v1/contents/1",
				 params: {downvoted:true,notes:"Downvoted"},
				 headers: {'Authorization':"Bearer #{token}"}
				
				
				expect(json).to_not be_empty
				expect(json['notes']).to eq("Downvoted")

				expect(response).to have_http_status(:ok)
			end
# ----------------------------------------
			it "Invalid since upvote and downvote" do
				put "/api/v1/contents/1",
				 params: {upvoted:true,downvoted:true,notes:"Downvoted"},
				 headers: {'Authorization':"Bearer #{token}"}
				
				expect(response).to have_http_status(:unprocessable_entity)
			end
# -----------------------------------------
			it "Can't update content since invalid content id" do
				get "/api/v1/contents/12", params: {}, headers: {'Authorization':"Bearer #{token}"}

				expect(response).to have_http_status(:not_found)
			end
	end
# --------------------------------------------------------------------------------------

end