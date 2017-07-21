require 'rails_helper'


describe "create a new link" do
  let(:link) {build(:link)}
  it "can add a new link with valid params" do
    post '/api/v1/user/:id/links', params: {url: link.url, title: link.title}

    expect(response).to be_success

    message = JSON.parse(response.body)
    expect(message).to eq("Link successfully created.")

    link1 = Link.last

    expect(Link.count).to eq(1)
    expect(link1.title).to eq(link.title)
    expect(link1.url).to eq(link.url)
    expect(link1.read).to be_false
  end
  it "cannot add a new link with invalid url" do
    post '/api/v1/user/:id/links', params: {url: "turing.io", title: link.title}

    expect(response).to be(422)

    message = JSON.parse(response.body)
    expect(message).to eq("Invalid URL!")

    expect(Link.count).to eq(0)
  end
  it "cannot add a new link with blank url" do
    post '/api/v1/user/:id/links', params: {url: "", title: link.title}

    expect(response).to be(422)

    message = JSON.parse(response.body)
    expect(message).to eq("Missing URL!")

    expect(Link.count).to eq(0)
  end
  it "cannot add a new link with blank title" do
    post '/api/v1/user/:id/links', params: {url: link.url, title: ""}

    expect(response).to be(422)

    message = JSON.parse(response.body)
    expect(message).to eq("Missing Title!")

    expect(Link.count).to eq(0)
  end
  it "cannot add a new link with invalid url and blank title" do
    post '/api/v1/user/:id/links', params: {url: "turing.io", title: ""}

    expect(response).to be(422)

    message = JSON.parse(response.body)
    expect(message).to eq("Invalid URL! Missing Title!")

    expect(Link.count).to eq(0)
  end
  it "cannot add a new link with missing url and title" do
    post '/api/v1/user/:id/links', params: {url: "", title: ""}

    expect(response).to be(422)

    message = JSON.parse(response.body)
    expect(message).to eq("Missing URL! Missing Title!")

    expect(Link.count).to eq(0)
  end
end
