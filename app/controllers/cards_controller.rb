class CardsController < ApplicationController
  def index
  	@cards = Card.all
  end

  def show
  	@card = Card.find(params[:id])
  end

  def new
  end

  def create
  	@card = Card.new(card_params)

  	@card.save
  	redirect_to @card
  end

  def update
    @card = Card.find(params[:id])

    if @card.update(card_params)
      redirect_to  @card
    else
      render 'edit'
    end
  end
  
  def edit
    @card = Card.find(params[:id])    
  end

private
  def card_params
    params.require(:card).permit(:original, :translated, :review)
  end
end
