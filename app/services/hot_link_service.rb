class HotLinkService

  def initialize
    @conn = Faraday.new("https://loliveri-hotreads.herokuapp.com")
  end

  def get_links
    response = conn.get("/api/v1/links")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_links
    service = HotLinkService.new
    service.get_links
  end

  private
    attr_reader :conn

end
