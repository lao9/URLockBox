require 'uri'

class Link < ActiveRecord::Base
  belongs_to :user

  def self.add_new_link(params)
    message = check_valid_params(params)
    if message.empty?
      create(params)
      {message: "Successfully added link!", link: Link.last, status: 200}
    else
      {message: message, status: 422}
    end
  end

  def self.check_valid_params(params)
    url = params[:url]
    title = params[:title]
    message = []
    message << "Invalid URL!" unless url =~ /\A#{URI::regexp(['http', 'https'])}\z/
    message << "Missing URL!" if url.empty?
    message << "Missing Title!" if title.empty?
    return message.join("\n")
  end

  def self.hot_links(user_id)
    where(user_id: user_id).order(:id).map do |raw_link|
      HotLink.new(raw_link)
    end
  end


end
