require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user)}
  let(:user_with_links) {create(:user_with_links)}

  describe "attributes" do
    it "responds to email" do
      expect(user).to respond_to(:email)
    end
    it "responds to password digest" do
      expect(user).to respond_to(:password_digest)
    end
  end

  describe "validations" do
    it { expect(user).to validate_presence_of(:email)}
    it { expect(user).to validate_uniqueness_of(:email)}
  end

  describe "relationships" do
    it "has many links" do
      should have_many(:links)
    end
    it "has valid factory with links associations" do
      expect(user_with_links).to respond_to(:links)
      expect(user_with_links.links.count).to eq(3)
      expect(user_with_links.links.first).to be_a(Link)
    end
  end
end
