require 'rails_helper'

RSpec.describe User, type: :model do

  #association tests
     # it { should belong_to(:board) }
     # it { should belong_to(:grade) }

  #validation tests
  before(:all) do
    create(:board)
    create(:grade)
  end

  it "is valid with valid attributes" do
    user = build(:user)  
    expect(user).to be_valid
  end

  describe "#name" do
    it "is not valid without a name" do 
      user = build(:user,name:nil)
      expect(user).to_not be_valid 
    end
  end

  describe "#email" do
    it "is not valid without an email" do
      user = build(:user,email:nil)
      expect(user).to_not be_valid 
    end

    it "Checks mail is valid" do
      user = build(:user,email:"abc")
      expect(user).to_not be_valid 
    end

    it "Checks mail is unique" do
      user1 = create(:user,mobile:"9087654433",board_id:1,grade_id:1)
      user2 = build(:user,board_id:1,grade_id:1)

      expect(user2).to_not be_valid 
    end
  end

  describe "#mobile" do
    it "is not valid without a mobile" do
      user = build(:user,mobile:nil)
      expect(user).to_not be_valid 
    end
    it "Checks mobile is valid" do
      user = build(:user,mobile:"1235780")
      expect(user).to_not be_valid
    end
    it "Checks mobile is unique" do
      user1 = create(:user,email:"ak@gmail.com",board_id:1,grade_id:1)
      user2 = build(:user,board_id:1,grade_id:1)
      expect(user2).to_not be_valid
    end
  end

end
