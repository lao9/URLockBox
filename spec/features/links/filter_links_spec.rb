require 'rails_helper'

feature "filter links spec", :js => true do
  let(:user) {create(:user_with_a_link)}
  before :each do
    user.links.create(title: "Turing BE Mod 4 Curriculum", url: "http://backend.turing.io/module4/", read: true)
    user.links.create(title: "Turing Room Scheduler", url: "https://turing.skedda.com")

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit root_path
  end
  context "by title or url" do
    scenario "returns appropriate results" do
      expect(page).to have_content("Filters:")
      expect(page).to have_content("By text:")

      within "#search-filter" do
        find('input').set "Ruby"
      end

      expect(page).to have_selector(".link", count: 1)
      expect(page).to have_content("Ruby Docs")
    end
    scenario "returns case insentitive results" do
      within "#search-filter" do
        find('input').set "tu"
      end

      expect(page).to have_selector(".link", count: 2)
      expect(page).to have_content("Turing BE")
      expect(page).to have_content("Turing Room")
    end
    scenario "returns confirmed search by url" do
      within "#search-filter" do
        find('input').set "http"
      end

      expect(page).to have_selector(".link", count: 3)
    end
  end
  context "by read" do
    xscenario "user can find only read links" do

    end
    xscenario "user can find only unread links" do

    end
  end
  context "by any filter" do
    xscenario "user can clear filters" do

    end
  end
end
