class HomeController < ApplicationController
  
  def index
  end

  def redirect_shortcode
    if params[:shortcode].present?
      @link = Link.where(shortcode: params[:shortcode]).first
      if @link.present?
        redirect_to @link.source_link
      else
        @error = "Can't find the URL, please check your link"
      end
    end
  end
end
