class CardsController < ApplicationController
  before_action :find_card, only: [:show, :edit, :update, :destroy]
  before_action :new_deck, only: [:create, :update]

  def index
    @cards = current_user.cards.all
  end

  def show
  end

  def new
    @card = Card.new
    @deck = @card.build_deck
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

  def new_deck
    @decks = current_user.decks
    if deck_params[:title].present?
      @decks.create(title: deck_params[:title])
    elsif card_params[:deck_id].present?
      @decks.find(card_params[:deck_id])
    end
  end

  def deck_params
    params.permit(:new_deck_name)
  end

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
