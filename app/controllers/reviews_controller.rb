class ReviewsController < ApplicationController
  def index
    @card = current_user.cards_for_review
  end

  def create
    @card = current_user.cards.find(review_params[:card_id])
    review = @card.check_translation(review_params[:user_translation])
    if review[:answer]
      flash[:notice] = "Правильно. Оригинальный текст: #{@card.original_text}, " \
                       "перевод: #{@card.translated_text}. " \
                       "Твой ответ: #{review_params[:user_translation]}. " \
                       "Опечатка: #{review[:typos]} буква. " \
                       "Дата следующей проверки: #{@card.review_date.strftime("%d/%m/%Y %H:%M")}"
    else
      flash[:alert] = "Неправильно, попробуй еще. " \
                      "Дата следующей проверки: #{@card.review_date.strftime("%d/%m/%Y %H:%M")}"
    end
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:card_id, :user_translation)
  end
end
