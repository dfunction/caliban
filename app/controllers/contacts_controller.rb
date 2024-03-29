class ContactsController < ApplicationController
  before_action :set_user
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = @user.contacts
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    @contact.build_pointer
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render action: 'show', status: :created, location: @contact }
      else
        format.html { render action: 'new' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      if (session[:id])
        @contact = Contact.find(params[:id])
        redirect_to root_path, status: :found if @contact.user_id != @user.id
      else
        redirect_to root_path, status: :found
      end
    end

    def set_user
      if (session[:id])
        @user = User.find(session[:id])
      else
        redirect_to root_path, status: :found
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      if params[:contact][:pointer_attributes][:id]
        @p = Pointer.find(params[:contact][:pointer_attributes][:id])
        if !@p || String(@p.contact.user_id) != String(@user.id)
          redirect_to root_path, status: :forbidden
        end
      end
      
      params[:contact][:user_id] = @user.id
      params.require(:contact).permit(:name, :user_id, :pointer_attributes => [:type, :value, :id])
    end
end
