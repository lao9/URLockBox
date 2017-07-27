class HotLink
  attr_reader :id, :title, :url, :read, :user_id, :status

  def initialize(link)
    @id = link.id
    @title = link.title
    @url = link.url
    @read = link.read
    @user_id = link.user_id
    @status = check_hot_links
  end

  def check_hot_links
    hot_links = HotLinkService.get_links.map {|raw_url| raw_url[:url] }
    return "not" unless hot_links.include?(url)
    return "top" if hot_links[0] == url
    "hot"
  end

end
