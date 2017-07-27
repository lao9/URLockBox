require "rails_helper"

RSpec.feature "can mark links as read", :js => :true do
  let(:user) {create(:user_with_a_link)}
  scenario "Mark a link as read" do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit root_path

    within('.link') do
      expect(page).to have_content("Read?: false")
      expect(page).to_not have_selector(".read")
    end

    click_on "Mark as Read"

    within('.link') do
      expect(page).to have_content("Read?: true")
      expect(page).to have_selector(".read")
    end

  end
end
