require 'rails_helper'

RSpec.describe Link, type: :model do
  let(:link) {create(:link)}

  describe "attributes" do
    it "responds to title" do
      expect(link).to respond_to(:title)
    end
    it "responds to url" do
      expect(link).to respond_to(:url)
    end
    it "responds to read" do
      expect(link).to respond_to(:read)
    end
  end

  describe "relationships" do
    it "belongs to user" do
      should belong_to(:user)
    end
  end
end
