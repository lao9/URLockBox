class LinksController < ApplicationController
  before_action :authenticate_user
  before_action :set_link, only: [:edit, :update]

  def index
    @link = current_user.links.new
    @links = current_user.links.order(:id)
  end

  def edit
  end

  def update
    errors = Link.check_valid_params(link_params)
    if errors.empty?
      @link.update(link_params)
      flash[:notice] = "Successfully updated link!"
      redirect_to links_path
    else
      flash.now[:error] = errors
      render :edit
    end
  end

  private

    def link_params
      params.require(:link).permit(:url, :title)
    end

    def set_link
      @link = current_user.links.find(params[:id])
    end
end
