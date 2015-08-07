class ReviewsController < ApplicationController
  def index
    @card = Card.for_review.first
  end

  def create
    @card = Card.find(review_params[:card_id])
    if @card.update_translation(review_params[:user_translation])
      flash[:notice] = "Good!!!"
    else
      flash[:alert] = "Wrong!!!"
    end
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:card_id, :user_translation)
  end
end