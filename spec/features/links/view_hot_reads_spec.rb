require 'rails_helper'

feature "top and hot links" do
  let(:user) {create(:user_with_a_link)}
  before :each do
    host = "https://loliveri-hotreads.herokuapp.com"
    conn = Faraday.new(host)
    conn.get("/api/v1/reset")
    user.links.create(title: "Bootstrap Getting Started", url: "http://getbootstrap.com/getting-started/")
    user.links.create(title: "Big O Cheat Sheet", url: "http://bigocheatsheet.com/")

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit root_path
  end
  scenario "user with an existing top or hot link is displayed" do
    link1, link2, link3 = user.links

    within "#link-#{link1.id}" do
      within ".spicy" do
        expect(page).to_not have_content("TOP HOT READ!!")
        expect(page).to have_content("SPICY READ!!")
      end
    end

    within "#link-#{link2.id}" do
      within ".top" do
        expect(page).to have_content("TOP HOT READ!!")
        expect(page).to_not have_content("SPICY READ!!")
      end
    end

    within "#link-#{link3.id}" do
      expect(page).to_not have_content("TOP HOT READ!!")
      expect(page).to_not have_content("SPICY READ!!")
    end
  end
  scenario "user can mark new link as red and it will become hot" do

    within "#link-#{link3.id}" do
      click_on "Mark As Read"
    end

    within "#link-#{link3.id}" do
      click_on "Mark As Unread"
    end

    within "#link-#{link3.id}" do
      click_on "Mark As Read"
    end

    visit links_path

    within "#link-#{link1.id}" do
      within ".spicy" do
        expect(page).to_not have_content("TOP HOT READ!!")
        expect(page).to have_content("SPICY READ!!")
      end
    end

  end
end
