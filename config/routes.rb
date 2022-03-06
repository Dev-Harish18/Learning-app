Rails.application.routes.draw do

  namespace :api do 
    namespace :v1 do

      use_doorkeeper do
          skip_controllers :authorizations, :applications,
          :authorized_applications
      end 
    
      #Authentication
      post '/auth/signup' , to:'users#signup'
      post '/auth/signin' , to:'users#signin'
      delete '/auth/signout' , to:'users#signout' 

      #Profile
      get '/users/me' , to:"users#get_profile"
      put '/users/me' , to:"users#update_profile"

      #Enroll
      post '/users/enroll' , to:"users#enroll_user"

      #Students_Controller
      get "/boards",to:"students#get_boards"
      get "/boards/:id",to:"students#get_board"
      get "/grades/:id",to:"students#get_grade"
      get "/subjects/:id",to:"students#get_subject"
      get "/chapters/:id",to:"students#get_chapter"   
      get "/exercises/:id",to:"students#get_exercise"
      get "/questions/:id",to:"students#get_question"

      get "/contents/:id",to:"students#get_content"
      put "/contents/:id",to:"students#update_content" 

      #Test

      #Start Test
      post "/attempts",to:"tests#start_test"
      #Answer a question
      post "/attempts/:id/questions",to:"tests#answer_question"
      #Finish test 
      post "/attempts/:id",to:"tests#end_test"

    end
  end

end
