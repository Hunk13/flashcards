class CardsController < ApplicationController
  before_action :find_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = current_user.cards.all
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = current_user.cards.new(card_params)
    if @card.save
      redirect_to decks_path, notice: "Карта создана"
    else
      render "new"
    end
  end

  def update
    if @card.update(card_params)
      redirect_to @card, notice: "Данные карты обновлены"
    else
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to root_path, notice: "Карта удалена"
  end

  private

  def find_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text,
                                 :translated_text,
                                 :review_date,
                                 :picture,
                                 :deck_id)
  end
end
