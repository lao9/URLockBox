require 'rails_helper'

feature "add new link", :js => true do
  let(:user) {create(:user_with_links)}
  context "as authenticated user with valid params" do
    scenario "new link is appended to list of links" do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit root_path

      within "#link-1" do
        click_on "Edit"
      end

      expect(current_path).to eq(edit_link_path(Link.find(1)))

      within ".link-edit" do
        fill_in "link[url]", with: "https://github.com"
        fill_in "link[title]", with: "Github"
        click_on "Update Link"
      end

      expect(page).to have_content("Successfully updated link!")

      expect(current_path).to eq(links_path)
      
      within "#link-1" do
        expect(page).to have_content("Github")
        expect(page).to have_link("https://github.com")
        expect(page).to have_content("Read?: false")

        expect(page).to have_button("Mark as Read")
        expect(page).to have_button("Edit")
      end
    end
  end
  context "as authenticated user with invalid params" do
    xscenario "cannot add an invalid url" do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit root_path

      within ".link-form" do
        fill_in "link[url]", with: "turing.io"
        fill_in "link[title]", with: "Turing"
        click_on "Add Link"
      end

      expect(page).to have_content("Invalid URL!")

      within ".links" do
        expect(page).to have_selector(".link", count: 3)
      end
    end
    xscenario "cannot add missing url" do
      allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

      visit root_path

      within ".link-form" do
        fill_in "link[url]", with: ""
        fill_in "link[title]", with: "Turing"
        click_on "Add Link"
      end

      expect(page).to have_content("Missing URL!")

      within ".links" do
        expect(page).to have_selector(".link", count: 3)
      end
    end
    xscenario "cannot add missing title" do
      allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

      visit root_path

      within ".link-form" do
        fill_in "link[url]", with: "http://turing.io"
        fill_in "link[title]", with: ""
        click_on "Add Link"
      end

      expect(page).to have_content("Missing Title!")

      within ".links" do
        expect(page).to have_selector(".link", count: 3)
      end
    end
    xscenario "cannot add invalid link OR title" do
      allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

      visit root_path

      within ".link-form" do
        fill_in "link[url]", with: "turing.io"
        fill_in "link[title]", with: ""
        click_on "Add Link"
      end

      expect(page).to have_content("Invalid URL! Missing Title!")

      within ".links" do
        expect(page).to have_selector(".link", count: 3)
      end
    end
    xscenario "cannot add missing link OR title" do
      allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

      visit root_path

      within ".link-form" do
        fill_in "link[url]", with: ""
        fill_in "link[title]", with: ""
        click_on "Add Link"
      end

      expect(page).to have_content("Missing URL! Missing Title!")

      within ".links" do
        expect(page).to have_selector(".link", count: 3)
      end
    end
  end
end
