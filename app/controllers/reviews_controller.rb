class ReviewsController < ApplicationController
  def index
    @card = current_user.cards_for_review
  end

  def create
    @card = current_user.cards.find(review_params[:card_id])
    review = @card.check_translation(review_params[:user_translation])
    if review[:success]
      flash[:notice] = "Правильно. Оригинальный текст: #{@card.original_text}, " \
                       "перевод: #{@card.translated_text}. " \
                       "Твой ответ: #{review_params[:user_translation]}. " \
                       "Опечатка: #{review[:typos]}. " \
                       "Дата следующей проверки: #{@card.review_date.localtime}"
    else
      flash[:alert] = "Неправильно, попробуй еще. " \
                      "Дата следующей проверки: #{@card.review_date.localtime}"
    end
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:card_id, :user_translation)
  end
end
