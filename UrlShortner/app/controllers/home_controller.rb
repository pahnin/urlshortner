class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:redirect_shortcode, :index]
  
  def index
  end

  def showkey
  end

  def updatekey
    current_user.key = SecureRandom.uuid
    if current_user.save!
      flash[:notice] = "Key was successfully updated."
    else
      flash[:notice] = "Unable to update key."
    end
    redirect_to apikey_url
    return
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
