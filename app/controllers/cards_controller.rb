class CardsController < ApplicationController
  before_action :find_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = current_user.cards
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
      redirect_to decks_path
    else
      render "new"
    end
  end

  def update
    if @card.update(card_params)
      redirect_to @card
    else
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to root_path, notice: "Card deleted"
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
    params.require(:deck).permit(:title)
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
