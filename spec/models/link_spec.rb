require 'rails_helper'

RSpec.describe Link, type: :model do
  let(:link) {create(:link)}

  describe "attributes" do
    it { expect(link).to respond_to(:title) }
    it { expect(link).to respond_to(:url) }
    it { expect(link).to respond_to(:read) }
    it "should have a default value of read as false" do
      link = Link.create(title: "Stuff", url: "http://ruby-doc.org/")
      expect(link.read).to be false
    end
  end

  describe "relationships" do
    it { should belong_to(:user) }
  end
end
