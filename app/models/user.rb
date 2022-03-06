class User < ApplicationRecord

  has_secure_password 
  has_many :user_contents

  belongs_to :board,optional:true
  belongs_to :grade,optional:true 

  validates :name,presence:true
  validates :email, presence: true,uniqueness: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  validates :mobile,presence:true,uniqueness: true,format: /\A[0-9]{10}\z/

  class << self
   def Authenticate(email, password)
     user = User.find_by(email: email)
     return user.authenticate(password) ? user : nil
   end
 end
end
