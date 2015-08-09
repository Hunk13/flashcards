class ReviewsController < ApplicationController
  def index
    @card = Card.for_review.first
  end

  def create
    @card = Card.find(review_params[:card_id])
    if @card.update_translation_date(review_params[:user_translation])
      flash[:notice] = "Правильный перевод"
    else
      flash[:alert] = "Неправильно, попробуй еще"
    end
    redirect_to :back
  end

  private

  def review_params
    params.require(:review).permit(:card_id, :user_translation)
  end

end
