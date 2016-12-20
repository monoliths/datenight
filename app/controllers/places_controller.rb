class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :create, :update, :destroy]
  before_action :set_place, only: [:show, :edit, :update, :destroy]


  # GET /places
  # GET /places.json
  def index
    @places = Place.search(params[:search])
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @review = Review.new
    @current_user_review = current_user ? current_user.reviews.find_by(place_id: @place.id) : nil
    @reviews = @place.reviews
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  # POST /places.json
  def create
    @place = current_user.places.new(place_params)
    current_user_review = current_user.reviews.find_by(place_id: @place.id)

    respond_to do |format|
      if current_user_review
        format.html { render :new, notice: 'Your review already exists.' }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      elsif @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :new }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { render :show, status: :ok, location: @place }
      else
        format.html { render :edit }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url, notice: 'Place was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name, :address, :description, :phone, :website)
    end

    def does_review_for_current_user_exist?(place_id)
        current_user.reviews.exists?(place_id: place_id)
    end
end
