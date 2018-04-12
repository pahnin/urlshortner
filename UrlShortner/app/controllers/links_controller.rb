class LinksController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :json_request?
  before_action :login_wrapper
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # GET /links
  # GET /links.json
  def index
    @links = current_user.links
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
    @link.user = current_user
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)
    @link.user = current_user

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def link_params
    if json_request?
      params.permit(:source_link)
    else
      params.require(:link).permit(:source_link, :key)
    end
  end

  def json_params
    params.permit(:key)
  end
  
  def login_wrapper
    if request.format.json?
      if json_params[:key].present?
        keybased_user = User.where(key: json_params[:key]).first
        if keybased_user.present?
          sign_in(:user, keybased_user)
        else
          return invalid_login_attempt
        end
      else
        return invalid_login_attempt
      end
    else
      authenticate_user!
    end
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end

  def json_request?
    request.format.json?
  end
end
