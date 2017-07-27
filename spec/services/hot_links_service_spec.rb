require 'rails_helper'

describe HotLinkService do
  it "returns current hot reads" do
    VCR.use_cassette('hot_read_service') do
      hot_links = HotLinkService.get_links

      expect(hot_links).to be_an(Array)
      expect(hot_links.first[:url]).to eq("http://getbootstrap.com/getting-started/")
      expect(hot_links.last[:url]).to eq("https://mail.google.com")
    end
  end
end
