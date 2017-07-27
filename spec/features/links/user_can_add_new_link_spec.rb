require 'rails_helper'

feature "add new link", :js => true do
  let(:user) {create(:user_with_links)}
  context "as authenticated user with valid params" do
    scenario "new link is appended to list of links" do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit root_path

      within ".link-form" do
        fill_in "link[url]", with: "http://turing.io"
        fill_in "link[title]", with: "Turing"
        click_on "Add Link"
      end

      within ".links" do
        expect(page).to have_selector(".link", count: 4)
      end

      expect(page).to have_content("Successfully added link!")

      within "#link-#{Link.last.id}" do
        expect(page).to have_content("Turing")
        expect(page).to have_link("http://turing.io")
        expect(page).to have_content("Read?: false")

        expect(page).to have_button("Mark as Read")
        expect(page).to have_button("Edit")
      end
    end
    scenario "multiple links can be added in a row" do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit root_path

      within ".link-form" do
        fill_in "link[url]", with: "http://turing.io"
        fill_in "link[title]", with: "Turing"
        click_on "Add Link"
      end

      within ".links" do
        expect(page).to have_selector(".link", count: 4)
      end

      within ".link-form" do
        fill_in "link[url]", with: "http://ruby-doc.org/"
        fill_in "link[title]", with: "Ruby Docs"
        click_on "Add Link"
      end

      within ".links" do
        expect(page).to have_selector(".link", count: 5)
      end
    end
  end
  context "as authenticated user with invalid params" do
    scenario "cannot add an invalid url" do
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
    scenario "cannot add missing url" do
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
    scenario "cannot add missing title" do
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
    scenario "cannot add invalid link OR title" do
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
    scenario "cannot add missing link OR title" do
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
