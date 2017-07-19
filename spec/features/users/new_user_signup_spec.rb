require 'rails_helper'

feature "new user sign up" do
  context "as an unauthenticated user" do
    let(:user) {build(:user)}
    let(:existing_user) {create(:user)}
    scenario "navigate to sign in page from root" do
      visit root_path

      click_on 'Sign up by clicking here'

      expect(current_path).to eq(new_user_path)
    end
    scenario "can create an account with all field filled out" do
      visit new_user_path

      within ".well" do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password
        click_on "Sign Up"
      end

      expect(page).to have_content("Welcome!")
      expect(current_path).to eq(links_path)
      expect(page).to have_content("Logout")

      expect(page).to_not have_content "Sign up"
      expect(page).to_not have_content "Login"
    end
    scenario "they provide an email that's already taken" do
      visit new_user_path

      within ".well" do
        fill_in 'user[email]', with: existing_user.email
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password
        click_on "Sign Up"
      end

      expect(page).to have_content("Email account already exists!")
      expect(current_path).to eq(new_user_path)
      expect(page).to have_content "Sign Up"
      expect(page).to have_content "Log in"
      expect(page).to_not have_content("Logout")
    end
    scenario "they fail to provide an email address" do
      visit new_user_path

      within ".well" do
        fill_in 'user[email]', with: ""
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password
        click_on "Sign Up"
      end

      expect(page).to have_content("Please fill out email field.")
      expect(current_path).to eq(new_user_path)
      expect(page).to have_content "Sign Up"
      expect(page).to have_content "Log in"
      expect(page).to_not have_content("Logout")
    end
    scenario "they provide blank password" do
      visit new_user_path

      within ".well" do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: ""
        fill_in 'user[password_confirmation]', with: user.password
        click_on "Sign Up"
      end

      expect(page).to have_content("Please fill out password field.")
      expect(current_path).to eq(new_user_path)
      expect(page).to have_content "Sign Up"
      expect(page).to have_content "Log in"
      expect(page).to_not have_content("Logout")
    end
    scenario "they provide no password confirmation" do
      visit new_user_path

      within ".well" do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: ""
        click_on "Sign Up"
      end

      expect(page).to have_content("Please fill out password confirmation field.")
      expect(current_path).to eq(new_user_path)
      expect(page).to have_content "Sign Up"
      expect(page).to have_content "Log in"
      expect(page).to_not have_content("Logout")
    end
    scenario "they provide no password OR confirmation" do
      visit new_user_path

      within ".well" do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: ""
        fill_in 'user[password_confirmation]', with: ""
        click_on "Sign Up"
      end

      expect(page).to have_content("Please fill out password field. Please fill out password confirmation field.")
      expect(current_path).to eq(new_user_path)
      expect(page).to have_content "Sign Up"
      expect(page).to have_content "Log in"
      expect(page).to_not have_content("Logout")
    end
    scenario "they provide incorrect password confirmation" do
      visit new_user_path

      within ".well" do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: "blah blah"
        click_on "Sign Up"
      end

      expect(page).to have_content("Password confirmation does not match.")
      expect(current_path).to eq(new_user_path)
      expect(page).to have_content "Sign Up"
      expect(page).to have_content "Log in"
      expect(page).to_not have_content("Logout")
    end
  end
end
