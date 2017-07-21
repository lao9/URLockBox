class Api::V1::LinksController < ApplicationController

  def create
    outcome = Link.add_new_link(link_create_params)
    if outcome[:status] == 200
      render partial: 'links/link', locals: {link: outcome[:link]}, layout: false
    else
      flash.now[:notice] = outcome[:message]
    end
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(link_params)
      render json: @link
    else
      render json: @link.errors.full_messages, status: 500
    end
  end

  private

  def link_create_params
    params.require(:link).permit(:user_id, :url, :title)
  end

  def link_params
    params.permit(:read)
  end
end
