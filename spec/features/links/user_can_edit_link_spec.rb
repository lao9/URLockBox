require 'rails_helper'

feature "add new link", :js => true do
  let(:user) {create(:user_with_links)}
  before :each do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit root_path

    within "#link-1" do
      click_on "Edit"
    end
  end
  context "as authenticated user with valid params" do
    scenario "new link is appended to list of links" do
      expect(current_path).to eq(edit_link_path(Link.find(1)))

      fill_in "link[url]", with: "https://github.com"
      fill_in "link[title]", with: "Github"
      click_on "Update Link"

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
    scenario "cannot add an invalid url" do
      fill_in "link[url]", with: "github.com"
      fill_in "link[title]", with: "Github"
      click_on "Update Link"

      expect(page).to have_content("Invalid URL!")
      expect(page).to have_content("Edit Link")
      expect(Link.find(1).url).to eq("http://ruby-doc.org/")
      expect(Link.find(1).title).to eq("Ruby Docs")
    end
    scenario "cannot add missing url" do
      fill_in "link[url]", with: ""
      fill_in "link[title]", with: "Github"
      click_on "Update Link"

      expect(page).to have_content("Invalid URL! Missing URL!")
      expect(page).to have_content("Edit Link")
      expect(Link.find(1).url).to eq("http://ruby-doc.org/")
      expect(Link.find(1).title).to eq("Ruby Docs")
    end
    scenario "cannot add missing title" do
      fill_in "link[url]", with: "https://github.com"
      fill_in "link[title]", with: ""
      click_on "Update Link"

      expect(page).to have_content("Missing Title!")
      expect(page).to have_content("Edit Link")
      expect(Link.find(1).url).to eq("http://ruby-doc.org/")
      expect(Link.find(1).title).to eq("Ruby Docs")
    end
    scenario "cannot add invalid link OR title" do
      fill_in "link[url]", with: "github.com"
      fill_in "link[title]", with: ""
      click_on "Update Link"

      expect(page).to have_content("Invalid URL! Missing Title!")
      expect(page).to have_content("Edit Link")
      expect(Link.find(1).url).to eq("http://ruby-doc.org/")
      expect(Link.find(1).title).to eq("Ruby Docs")
    end
    scenario "cannot add missing link OR title" do
      fill_in "link[url]", with: ""
      fill_in "link[title]", with: ""
      click_on "Update Link"

      expect(page).to have_content("Invalid URL! Missing URL! Missing Title!")
      expect(page).to have_content("Edit Link")
      expect(Link.find(1).url).to eq("http://ruby-doc.org/")
      expect(Link.find(1).title).to eq("Ruby Docs")
    end
  end
end
