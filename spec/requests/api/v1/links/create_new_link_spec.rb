require 'rails_helper'


describe "create a new link" do
  let(:user) {create(:user)}
  let(:link) {build(:link)}
  it "can add a new link with valid params" do
    post '/api/v1/links', params: {user_id: user.id, url: link.url, title: link.title}

    expect(response).to be_success

    outcome = JSON.parse(response.body)
    expect(outcome['message']).to eq("Link successfully created.")

    link1 = Link.last

    expect(Link.count).to eq(1)
    expect(link1.title).to eq(link.title)
    expect(link1.url).to eq(link.url)
    expect(link1.read).to be false

    expect(user.links.count).to eq(1)
    expect(user.links.last).to eq(link1)
  end
  it "cannot add a new link with invalid url" do
    post '/api/v1/links', params: {user_id: user.id, url: "turing.io", title: link.title}

    expect(response.status).to eq(422)

    outcome = JSON.parse(response.body)
    expect(outcome['message']).to eq("Invalid URL!")

    expect(Link.count).to eq(0)
  end
  it "cannot add a new link with blank url" do
    post '/api/v1/links', params: {user_id: user.id, url: "", title: link.title}

    expect(response.status).to eq(422)

    outcome = JSON.parse(response.body)
    expect(outcome['message']).to eq("Invalid URL!\nMissing URL!")

    expect(Link.count).to eq(0)
  end
  it "cannot add a new link with blank title" do
    post '/api/v1/links', params: {user_id: user.id, url: link.url, title: ""}

    expect(response.status).to eq(422)

    outcome = JSON.parse(response.body)
    expect(outcome['message']).to eq("Missing Title!")

    expect(Link.count).to eq(0)
  end
  it "cannot add a new link with invalid url and blank title" do
    post '/api/v1/links', params: {user_id: user.id, url: "turing.io", title: ""}

    expect(response.status).to eq(422)

    outcome = JSON.parse(response.body)
    expect(outcome['message']).to eq("Invalid URL!\nMissing Title!")

    expect(Link.count).to eq(0)
  end
  it "cannot add a new link with missing url and title" do
    post '/api/v1/links', params: {user_id: user.id, url: "", title: ""}

    expect(response.status).to eq(422)

    outcome = JSON.parse(response.body)
    expect(outcome['message']).to eq("Invalid URL!\nMissing URL!\nMissing Title!")

    expect(Link.count).to eq(0)
  end
end
