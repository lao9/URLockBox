class LinksController < ApplicationController
  before_action :authenticate_user

  def index
    @links = current_user.links.order(:id)
  end

end
