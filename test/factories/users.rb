FactoryGirl.define do
  factory :user do
      # User.new(name: "User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
      name 'User'
      sequence :email do |n|
        "user#{n}@example.com"
      end
      
      password "foobar"
      password_confirmation "foobar"
  end
end
