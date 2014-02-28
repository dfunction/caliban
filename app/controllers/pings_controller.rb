class PingsController < ApplicationController
  before_action :set_user
  before_action :set_ping, only: [:show, :edit, :update, :destroy]

  # GET /pings
  # GET /pings.json
  def index
    @pings = @user.pings
  end

  # GET /pings/1
  # GET /pings/1.json
  def show
  end

  # GET /pings/new
  def new
    @ping = Ping.new
    @ping.build_contactping
    @contacts = @user.contacts
  end

  # GET /pings/1/edit
  def edit
    @contacts = @user.contacts
  end

  # POST /pings
  # POST /pings.json
  def create
    @ping = Ping.new(ping_params)

    respond_to do |format|
      if @ping.save
        format.html { redirect_to @ping, notice: 'Ping was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ping }
      else
        format.html { render action: 'new' }
        format.json { render json: @ping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pings/1
  # PATCH/PUT /pings/1.json
  def update
    respond_to do |format|
      if @ping.update(ping_params)
        format.html { redirect_to @ping, notice: 'Ping was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pings/1
  # DELETE /pings/1.json
  def destroy
    @ping.destroy
    respond_to do |format|
      format.html { redirect_to pings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ping
      if (session[:id])
        @ping = Ping.find(params[:id])
        redirect_to root_path, status: :forbidden if @ping.user_id != @user.id
      else
        redirect_to root_path, status: :forbidden
      end
    end
    
    def set_user
      if (session[:id])
        @user = User.find(session[:id])
      else
        redirect_to root_path, status: :forbidden
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ping_params
      if params[:ping][:contactping_attributes][:id]
        @cp = Contactping.find(params[:ping][:contactping_attributes][:id])
        if !@cp || String(@cp.contact.user_id) != String(@user.id)
          redirect_to root_path, status: :forbidden
        end
      end
      
      params[:ping][:user_id] = @user.id
      params.require(:ping).permit(:frequency, :type, :user_id, contactping_attributes: [:contact_id, :id])
    end
    
end
