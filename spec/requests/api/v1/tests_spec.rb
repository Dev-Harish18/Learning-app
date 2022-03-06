require 'rails_helper'

RSpec.describe "Api::V1::Tests", type: :request do
  
  token=""

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


    post "/api/v1/auth/signup",params:{
                name:"Harish",
                email:"har@gmail.com",
                mobile:"9907654321",
                dob:"2021-03-01",
                password:"pass1234",
                password_confirmation:"pass1234"
              }
              
    token = JSON.parse(response.body)['auth_token']['access_token']
  end
# ------------------------------------------------------------------------------------------
  describe "Start Test" do
      it "Test started successfully" do
        post "/api/v1/attempts",params:{exercise_id:1},headers: {'Authorization':"Bearer #{token}"}

        expect(json['questions'].size).to eq(5)
        expect(json['attempt_id']).to eq(1)
        expect(response).to have_http_status(:created)  
      end
# ------------------------------------
      it "Test cannot be started since exercise id invalid" do
        post "/api/v1/attempts",params:{exercise_id:8},headers: {'Authorization':"Bearer #{token}"}

        expect(response).to have_http_status(:unprocessable_entity)  
      end
  end
# -------------------------------------------------------------------------------------------
  describe "Answer a question" do
      before(:all) do
        post "/api/v1/attempts",params:{exercise_id:1},headers: {'Authorization':"Bearer #{token}"}
      end


      it "Answered successfully" do
        post "/api/v1/attempts/1/questions",params:{submitted_answer:"correct option",question_id:1},
        headers: {'Authorization':"Bearer #{token}"}
        
        expect(response).to have_http_status(:created)
      end
# --------------------------------------
      it "Cannot answer since invalid attempt id" do
        post "/api/v1/attempts/10/questions",params:{submitted_answer:"correct option",question_id:1},
        headers: {'Authorization':"Bearer #{token}"}
        
        expect(response).to have_http_status(:not_found)
      end
# --------------------------------------
      it "Cannot answer since invalid question id" do
        post "/api/v1/attempts/1/questions",params:{submitted_answer:"correct option",question_id:12},
        headers: {'Authorization':"Bearer #{token}"}
        
        expect(response).to have_http_status(:not_found)
      end
  end
#----------------------------------------------------------------------------------------------- 
  describe "End test" do
      before(:all) do
        post "/api/v1/attempts",params:{exercise_id:1},headers: {'Authorization':"Bearer #{token}"}
        # raise response.body
        post "/api/v1/attempts/1/questions",params:{submitted_answer:"correct option",question_id:1},headers: {'Authorization':"Bearer #{token}"}
        post "/api/v1/attempts/1/questions",params:{submitted_answer:"correct option",question_id:2},headers: {'Authorization':"Bearer #{token}"}
      end


      it "Attempt returned successfully" do
        post "/api/v1/attempts/1",params:{time_spent:20},
        headers: {'Authorization':"Bearer #{token}"}
        
        # raise response.body
        expect(json['total_score']).to eq(2)
        expect(response).to have_http_status(:ok)
      end
# --------------------------------------
      it "Attempt was not returned since invalid attempt id" do
        post "/api/v1/attempts/12",params:{submitted_answer:"correct option",question_id:1},
        headers: {'Authorization':"Bearer #{token}"}
        
        expect(response).to have_http_status(:not_found)
      end
# --------------------------------------
      it "Attempt was not returned since time_spent is missing" do
        post "/api/v1/attempts/1",params:{submitted_answer:"correct option",question_id:12},
        headers: {'Authorization':"Bearer #{token}"}
        
        expect(response).to have_http_status(:unprocessable_entity)
      end
  end

end
