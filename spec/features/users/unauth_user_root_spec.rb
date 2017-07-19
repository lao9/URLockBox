require 'rails_helper'

feature "login process" do
  let(:user) {create(:user)}
  context "as an unauthenticated user" do
    scenario "see login page" do
      visit root_path

      within 'h1' do
        expect(page).to have_content('Login')
      end

      expect(current_path).to eq(login_path)
    end
    scenario "see login page" do
      visit root_path

      within ".well" do
        fill_in "session[email]", with: user.email
        fill_in "session[password]", with: user.password
        click_on "Login"
      end

      expect(page).to have_content("Welcome!")
      expect(current_path).to eq(links_path)
      expect(page).to have_content("Logout")

      expect(page).to_not have_content "Sign up"
      expect(page).to_not have_content "Login"
    end
    scenario "they provide invalid email" do
      visit login_path

      fill_in "session[email]", with: "lollllll@lol.com"
      fill_in "session[password]", with: user.password
      click_button "Login"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Invalid Username or Password!")

      expect(page).to_not have_content "Logout"
      expect(page).to have_content "Sign up"
      expect(page).to have_content "Login"
    end
    scenario "they provide invalid password" do
      visit login_path

      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: "blah"
      click_on "Login"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Invalid Username or Password!")

      expect(page).to_not have_content "Logout"
      expect(page).to have_content "Sign up"
      expect(page).to have_content "Login"
    end
    scenario "they provide blank email" do
      visit login_path

      fill_in "session[email]", with: ""
      fill_in "session[password]", with: user.password
      click_button "Login"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Invalid Username or Password!")

      expect(page).to_not have_content "Logout"
      expect(page).to have_content "Sign up"
      expect(page).to have_content "Login"
    end
    scenario "they provide blank password" do
      visit login_path

      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: ""
      click_button "Login"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Invalid Username or Password!")

      expect(page).to_not have_content "Logout"
      expect(page).to have_content "Sign up"
      expect(page).to have_content "Login"
    end
  end
end
