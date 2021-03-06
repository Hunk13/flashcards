module Dashboard
  class ReviewsController < BaseController
    def index
      @card = current_user.cards_for_review
      respond_to do |format|
        format.html
        format.js
      end
    end

    def create
      @card = current_user.cards.find(review_params[:card_id])
      @review = @card.check_translation(review_params[:user_translation],
                                        review_params[:seconds])
      @review[:user_translation] = review_params[:user_translation]
      if @review[:success]
        flash[:notice] = t("controller.reviews.success",
                           original: @card.original_text,
                           translated: @card.translated_text,
                           user_answer: review_params[:user_translation],
                           typos: @review[:typos],
                           next_review: card_time_loc)
      else
        flash[:alert] = t("controller.reviews.fail",
                          next_review: card_time_loc)
      end
      redirect_to root_path
    end

    private

    def review_params
      params.require(:review).permit(:card_id, :user_translation, :seconds)
    end

    def card_time_loc
      @card.review_date.localtime.strftime("%d/%m/%Y %H:%M")
    end
  end
end
