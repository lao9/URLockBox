require 'rails_helper'

feature "view link index" do
  context "as an authenticated user with links" do
    let(:user) {create(:user_with_links)}
    xscenario "when I navigate to the root i'm directed to the index" do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit root_path

      expect(current_path).to eq(links_path)
    end
    xscenario "all links are present on the page" do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit root_path

      within ".links" do
        expect(page).to have_selector(".link", 3)
      end

      link1 = user.links.first

      within "#link-1" do
        expect(page).to have_content(link1.title)
        expect(page).to have_content(link1.url)
        expect(page).to have_content("Read?: false")

        expect(page).to have_button("Mark as Read")
        expect(page).to have_button("Edit")
      end
    end
  end
end
