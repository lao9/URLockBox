require 'rails_helper'

feature "view link index" do
  context "as an authenticated user with links" do
    let(:user) {create(:user_with_links)}
    scenario "all links are present on the page" do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit root_path

      within "h1" do
        expect(page).to have_content("Your URLockBox")
      end

      within ".links" do
        expect(page).to have_selector(".link", 3)
      end

      link1 = user.links.first

      within "#link-#{link1.id}" do
        expect(page).to have_content(link1.title)
        expect(page).to have_link(link1.url)
        expect(page).to have_content("Read?: false")

        expect(page).to have_button("Mark as Read")
        expect(page).to have_button("Edit")
      end
    end
  end
end
