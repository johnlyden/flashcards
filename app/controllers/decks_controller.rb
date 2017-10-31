class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :edit, :update, :destroy]

  # GET /decks
  # GET /decks.json
  def index
    @decks = Deck.all
  end

  # GET /decks/1
  # GET /decks/1.json
  def show
  end

  # happens when we GET '/decks/:id/setup'
  def setup_game
    @deck = Deck.find(params[:id]) 
    @user = User.first
    @round = Round.create({user_id: @user.id, deck_id: @deck.id})
    
    # adds all fo the card id's to an array stored in the round
    @round.setup(@deck)

    redirect_to "/cards/#{@deck.cards.first.id}/play/#{@round.id}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deck
      @deck = Deck.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deck_params
      params.require(:deck).permit(:name, :description)
    end
end
