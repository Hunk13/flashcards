class ReviewsController < ApplicationController
  def index
    @card = current_user.cards_for_review
  end

  def create
    @card = current_user.cards.find(review_params[:card_id])
    review = @card.check_translation(review_params[:user_translation],
                                     review_params[:quality].to_i)
    if review[:result]
      flash[:notice] = t("controller.reviews.success",
                         original: @card.original_text,
                         translated: @card.translated_text,
                         user_answer: review_params[:user_translation],
                         typos: review[:typos],
                         next_review: @card.review_date.localtime.strftime("%d/%m/%Y %H:%M"))
    else
      flash[:alert] = t("controller.reviews.fail",
                        next_review: @card.review_date.localtime.strftime("%d/%m/%Y %H:%M"))
    end
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:card_id, :user_translation, :quality)
  end
end
