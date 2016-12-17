class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :update, :edit]
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /Reviews/new
  def new
    @review = Review.new
  end

  # GET /Reviews/1/edit
  def edit
  end

  # POST /Reviews
  # POST /Reviews.json
  def create
    @review = current_user.reviews.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to place_path(@review.place), notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Reviews/1
  # PATCH/PUT /Reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to place_path(@review.place), notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Reviews/1
  # DELETE /Reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to place_path(@review.palce), notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:content, :place_id, :score)
    end



end
