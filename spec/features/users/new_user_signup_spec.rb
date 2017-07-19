feature "login process" do
  context "as an unauthenticated user" do
    let(:user) {build(:user)}
    scenario "navigate to sign in page from root" do
      visit root_path

      click_on 'Sign up by clicking here'

      expect(current_path).to eq(new_user_path)
    end
    scenario "can create an account with all field filled out" do
      visit root_path

      within ".well" do
        fill_in :email, with: user.email
        fill_in :password, with: user.password
        fill_in :password_confirmation, with: user.password
        click_on "Sign Up"
      end

      expect(page).to have_content("Welcome!")
      expect(current_path).to eq(links_path)
      expect(page).to have_content("Logout")

      expect(page).to_not have_content "Sign up"
      expect(page).to_not have_content "Login"
    end
    xscenario "they provide invalid email" do
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
    xscenario "they provide invalid password" do
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
    xscenario "they provide blank email" do
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
    xscenario "they provide blank password" do
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
