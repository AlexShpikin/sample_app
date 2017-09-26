require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create :user }
	subject { user }
	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	it {should be_valid}

  describe "when name is not present" do
		before {user.name = "a"*48}
		it {should be_valid}
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                  foo@bar_baz.com foo@bar+baz.com]
    		addresses.each do |invalid_address|
      		user.email = invalid_address
      		expect(user).not_to be_valid
    		end
    	end
  end

  describe "when password is not present" do
  	before { user.password = user.password_confirmation = " " }
  	it { should_not be_valid }
	end

	describe "when password doesn't match confirmation" do
	  	before { user.password_confirmation = "mismatch" }
	  	it { should_not be_valid }
	end

  describe "when email format is valid" do
    it "should be valid" do
    	addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    	addresses.each do |valid_address|
      	user.email = valid_address
      	expect(user).to be_valid
    	end
    end
	end

  describe "when email address is already taken" do
    let(:same_email_user) { FactoryGirl.build :user, email: user.email.upcase }

    it { expect(same_email_user).not_to be_valid }
	end

  describe "return value of authenticate method" do
  	before { user.save }
  	let(:found_user) { User.find_by(email: user.email) }

  	describe "with valid password" do
    	it { should eq found_user.authenticate(user.password) }
  	end

  	describe "with invalid password" do
    	let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    	it { should_not eq user_for_invalid_password }
    	specify { expect(user_for_invalid_password).to be false }
  	end
	end

  describe "with a password that's too short" do
  	before { user.password = user.password_confirmation = "a" * 5 }
  	it { should be_invalid }
	end

  describe '.follow!' do
    let(:second_user) { FactoryGirl.create :user }
    before { user.follow!(second_user) }

    it 'creates relationship' do
      res = Relationship.find_by(follower: user, followed: second_user)
      expect(res.present?).to be_truthy
    end

  end

  describe '.following?' do
    let(:second_user) { FactoryGirl.create :user }

    it 'users aren\'t follows' do
      expect(user.following? second_user).to be_falsey
    end

    describe 'users are follows' do
      before { user.follow!(second_user) }      
      it { expect(user.following? second_user).to be_truthy }
    end
  end
  describe 'user unfollow!' do
    let(:second_user) { FactoryGirl.create :user }
    before { user.follow!(second_user) }
    it { expect(user.unfollow! second_user ).to be_truthy}
  end
end
