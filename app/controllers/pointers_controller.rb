class PointersController < ApplicationController
  before_action :set_pointer, only: [:show, :edit, :update, :destroy]

  # GET /pointers
  # GET /pointers.json
  def index
    @pointers = Pointer.all
  end

  # GET /pointers/1
  # GET /pointers/1.json
  def show
  end

  # GET /pointers/new
  def new
    @pointer = Pointer.new
  end

  # GET /pointers/1/edit
  def edit
  end

  # POST /pointers
  # POST /pointers.json
  def create
    @pointer = Pointer.new(pointer_params)

    respond_to do |format|
      if @pointer.save
        format.html { redirect_to @pointer, notice: 'Pointer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pointer }
      else
        format.html { render action: 'new' }
        format.json { render json: @pointer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pointers/1
  # PATCH/PUT /pointers/1.json
  def update
    respond_to do |format|
      if @pointer.update(pointer_params)
        format.html { redirect_to @pointer, notice: 'Pointer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pointer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pointers/1
  # DELETE /pointers/1.json
  def destroy
    @pointer.destroy
    respond_to do |format|
      format.html { redirect_to pointers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pointer
      @pointer = Pointer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pointer_params
      params.require(:pointer).permit(:type, :value, :contact_id)
    end
end
