require 'rails_helper'


describe "create a new link" do
  let(:user) {create(:user)}
  let(:link) {build(:link)}
  it "can add a new link with valid params" do
    post '/api/v1/links', params: {link: {user_id: user.id, url: link.url, title: link.title}}

    link1 = Link.last

    expect(Link.count).to eq(1)
    expect(link1.title).to eq(link.title)
    expect(link1.url).to eq(link.url)
    expect(link1.read).to be false

    expect(user.links.count).to eq(1)
    expect(user.links.last).to eq(link1)
  end
  it "cannot add a new link with invalid url" do
    post '/api/v1/links', params: {link: {user_id: user.id, url: "turing.io", title: link.title}}

    expect(Link.count).to eq(0)
  end
  it "cannot add a new link with blank url" do
    post '/api/v1/links', params: {link: {user_id: user.id, url: "", title: link.title}}

    expect(Link.count).to eq(0)
  end
  it "cannot add a new link with blank title" do
    post '/api/v1/links', params: {link: {user_id: user.id, url: link.url, title: ""}}

    expect(Link.count).to eq(0)
  end
  it "cannot add a new link with invalid url and blank title" do
    post '/api/v1/links', params: {link: {user_id: user.id, url: "turing.io", title: ""}}

    expect(Link.count).to eq(0)
  end
  it "cannot add a new link with missing url and title" do
    post '/api/v1/links', params: {link: {user_id: user.id, url: "", title: ""}}

    expect(Link.count).to eq(0)
  end
end
