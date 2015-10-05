class CardsController < ApplicationController
  before_action :find_card, only: [:show, :edit, :update, :destroy]
  before_action :create_deck, only: [:create, :update]

  def index
    @cards = current_user.cards
  end

  def show
  end

  def new
    @card = current_user.cards.new
  end

  def edit
  end

  def create
    @card = current_user.cards.new(card_params)
    if @card.save
      redirect_to cards_path, notice: t("controller.cards.create")
    else
      render "new"
    end
  end

  def update
    if @card.update(card_params)
      redirect_to @card, notice: t("controller.cards.update")
    else
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to root_path, notice: t("controller.cards.destroy")
  end

  private

  def create_deck
    new_deck = deck_params[:title]
    if new_deck.present?
      deck = current_user.decks.create(title: new_deck)
      params[:card][:deck_id] = deck.id
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
