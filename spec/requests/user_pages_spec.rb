require 'rails_helper'

RSpec.feature "user_controller_spec" do
  scenario "should have content 'Sign up" do
    visit '/signup'
    expect(page).to have_title('Sign up')
  end
end