require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  
    before(:all) do
      create(:board)
      create(:grade)
      create(:user)
    end

    describe 'Sign up' do

      it "signs up with valid data" do
        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654321",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass1234"
        }
        expect(response).to have_http_status(:created)
      end

      it "signup unsuccessful since password_confirmation doesn't match" do
        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654321",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass12"
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end      

      it "signup unsuccessful since email already taken" do
        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654321",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass1234"
        }

        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654320",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass1234"
        }
        expect(response).to have_http_status(:unprocessable_entity)
        # raise response.body
      end

      it "signup unsuccessful since mobile is invalid" do
        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"980765",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass12"
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end  

      it "signup unsuccessful since name is missing" do
        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"980765",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass12"
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end  
    end

    describe 'Sign in' do

      it "Signin successful since valid credentials" do
        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654321",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass1234"
        }

        post "/api/v1/auth/signin",params:{
          email:"hari@gmail.com",
          password:"pass1234"
        }

        expect(response).to have_http_status(:created)
      end

      it "Signin unsuccessful since password missing" do
        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654321",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass1234"
        }

        post "/api/v1/auth/signin",params:{
          email:"hari@gmail.com",
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end


      it "Signin unsuccessful since email missing" do
        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654321",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass1234"
        }

        post "/api/v1/auth/signin",params:{
          password:"pass1234"
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "Signin unsuccessful since email is invalid" do
        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654321",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass1234"
        }

        post "/api/v1/auth/signin",params:{
          email:"har@gmail.com",
          password:"pass1234"
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "Signin unsuccessful since password mismatches" do
        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654321",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass1234"
        }

        post "/api/v1/auth/signin",params:{
          email:"har@gmail.com",
          password:"pass12"
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
# ---------------------------------------------------------------------------------------------------

    describe 'Gets Profile' do

      it "retrieves profile with 200 status" do
        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654321",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass1234"
        }

        token = JSON.parse(response.body)['auth_token']['access_token']
        get "/api/v1/users/me", params: {}, headers: {'Authorization':"Bearer #{token}"}


        expect(JSON.parse(response.body)['id']).to eq(2)
        expect(response).to have_http_status(:ok)
      end

# -------------------------------------------------------
      it "displays error message when signed out" do
        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654321",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass1234"
        }
        token = JSON.parse(response.body)['auth_token']['access_token']

        delete "/api/v1/auth/signout",params: {}, headers: {'Authorization':"Bearer #{token}"}

        get "/api/v1/users/me", params: {}, headers: {'Authorization':"Bearer #{token}"}

        expect(response).to have_http_status(:unauthorized)
      end
# ------------------------------------------------------
      it "displays error message when access without token" do
        get "/api/v1/users/me"
        expect(response).to have_http_status(:unauthorized)
      end
# --------------------------------------------------------
      it "displays error message when access with invalid token" do
        get "/api/v1/users/me", params: {}, headers: {'Authorization':"Bearer 2we3rdf"}
        expect(response).to have_http_status(:unauthorized)
      end
    end

# ------------------------------------------------------------------------------------------------------

    describe 'Updates Profile' do

      it "updates profile with 200 status" do

        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654321",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass1234"
        }

        token = JSON.parse(response.body)['auth_token']['access_token']

        put "/api/v1/users/me",params: { 
          name:"Jana",
          email:"jana@gmail.com",
          dob:"12",
          mobile:"1234567890"
        },headers: {'Authorization':"Bearer #{token}"}

        expect(JSON.parse(response.body)['name']).to eq("Jana")
        expect(response).to have_http_status(:ok)
      end
# -------------------
      it "invalid user data since email is invalid" do

        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654321",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass1234"
        }
        token = JSON.parse(response.body)['auth_token']['access_token']

        put "/api/v1/users/me",params: { 
          email:"jana",
        },headers: {'Authorization':"Bearer #{token}"}

        expect(response).to have_http_status(:unprocessable_entity)
      end
# --------------------
      it "invalid user data since mobile is invalid" do
        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654321",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass1234"
        }
        token = JSON.parse(response.body)['auth_token']['access_token']

        put "/api/v1/users/me",params: { 
          mobile:"1235780"
        },headers: {'Authorization':"Bearer #{token}"}
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
# -----------------------------------------------------------------------------------------
    describe 'Enroll User' do

      it "Enrolls user since valid board and grade" do
        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654321",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass1234"
        }
        token = JSON.parse(response.body)['auth_token']['access_token']


        post "/api/v1/users/enroll",params:{board_id:1,grade_id:1},headers: {'Authorization':"Bearer #{token}"}

        expect(JSON.parse(response.body)['board_id']).to eq(1)
        expect(JSON.parse(response.body)['grade_id']).to eq(1)
        expect(response).to have_http_status(:ok)
      end
# ----------------------------------
      it "No Enrollment since invalid board" do
        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654321",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass1234"
        }
        token = JSON.parse(response.body)['auth_token']['access_token']

        post "/api/v1/users/enroll",params:{board_id:2},headers: {'Authorization':"Bearer #{token}"}
        expect(response).to have_http_status(:unprocessable_entity)
      end
# -----------------------------------
      it "No Enrollment since invalid board" do
        post "/api/v1/auth/signup",params:{
          name:"Harish",
          email:"hari@gmail.com",
          mobile:"9807654321",
          dob:"2021-03-01",
          password:"pass1234",
          password_confirmation:"pass1234"
        }

        post "/api/v1/auth/signin",params:{
          email:"hari@gmail.com",
          password:"pass1234"
        }

        token = JSON.parse(response.body)['auth_token']['access_token']


        post "/api/v1/users/enroll",params:{grade_id:2},headers: {'Authorization':"Bearer #{token}"}
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
# ------------------------------------
end
