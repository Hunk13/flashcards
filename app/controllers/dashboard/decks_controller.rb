class Dashboard::DecksController < Dashboard::BaseController
  before_action :find_deck, only: [:show, :edit, :update, :destroy]

  def index
    @decks = current_user.decks
  end

  def show
    @cards = @deck.cards
  end

  def new
    @deck = current_user.decks.new
  end

  def create
    @deck = current_user.decks.new(deck_params)
    if @deck.save
      redirect_to dashboard_decks_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @deck.update(deck_params)
      redirect_to dashboard_deck_path, notice: t("controller.decks.update")
    else
      render edit_dashboard_deck_path
    end
  end

  def destroy
    @deck.destroy
    redirect_to dashboard_decks_path
  end

  def set_current
    current_user.update_attributes(default_deck_id: params[:id])
    redirect_to dashboard_deck_path, notice: t("controller.decks.set")
  end

  private

  def find_deck
    @deck = current_user.decks.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:title)
  end
end
