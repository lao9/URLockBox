require 'rails_helper'

feature "user can log out" do
  let(:user) {create(:user)}
  context "as a logged in user" do
    scenario "user is logged in and clicks logout" do
      visit login_path

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password
      click_on "Login"

      click_on "Logout"
      expect(page).to have_content("Goodbye!")
      expect(page).to have_content("Login")
      expect(page).to_not have_content("Logout")
    end
  end
end
