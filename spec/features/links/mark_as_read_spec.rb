require "rails_helper"

RSpec.feature "can mark links as read", :js => :true do
  let(:user) {create(:user_with_a_link)}
  let(:user_read) {create(:user_with_a_read_link)}
  scenario "Mark a link as read" do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit root_path

    expect(page).to_not have_selector(".read")
    expect(page).to have_content("Read?: false")

    click_on "Mark as Read"

    expect(page).to have_selector(".read")
    expect(page).to have_content("Read?: true")
  end
  scenario "Mark a link as uread" do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user_read)

      visit root_path

      expect(page).to have_selector(".read")
      expect(page).to have_content("Read?: true")

      click_on "Mark as Unread"

      expect(page).to_not have_selector(".read")
      expect(page).to have_content("Read?: false")
  end
end
