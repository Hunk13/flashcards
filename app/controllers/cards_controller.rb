class CardsController < ApplicationController
  before_action :find_card, only: [:show, :edit, :update]

  def index
    @cards = Card.all
  end

  def show
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.create(card_params)
    redirect_to @card
  end

  def update
    if @card.update(card_params)
      redirect_to @card
    else
      render "edit"
    end
  end

  def edit
  end

  private

  def find_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original, :translated, :review)
  end
end
