require 'rails_helper'

RSpec.describe "AuthenticationPages", type: :request do  
    before do
    @user = User.new(name: "Example User", email: "user@example.com",
	                     password: "foobar", password_confirmation: "foobar")
	end

	subject { @user }
	
	describe "remember token" do
	    before { @user.save }
	    it {expect(:remember_token).not_to be_blank }
	end
end
