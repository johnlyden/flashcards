class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :edit, :update, :destroy]

  # this shows all of the decks we have - when we make the following request:
  # GET /decks
  def index
    @decks = Deck.all
  end

  # this shows information about the current deck - when we make the following request:
  # GET /decks/:deck_id
  def show
  end

  # happens when we GET '/decks/:id/setup'
  # sets up the initial conditions for a game
  def setup_game
    # find the deck the user wants to play - using the :id passed in through params
    @deck = Deck.find(params[:id]) 
    # find the user - currently just using the one user - when you add authentication you can change this to find the user based on the session[:user_id] or a method like current_user
    @user = User.first
    # create the round object - it needs a user_id and a deck_id - we get that from the @deck and @user we found above
    @round = Round.create({user_id: @user.id, deck_id: @deck.id})
    # store an array of the cards from the deck in the session - we need to remove cards from this array when we get one right
    # it is in the session because information in the session will persist and keep track of the state of the game.  the state of the game is basically how many cards are left to anser
    session[:cards_not_answered] = @deck.cards.map { |card|  card.id } 
    # redirect to the play_card route - /cards/:card_id/play/:round_id
    # this will redirect to that url, which will execute the play_card method that is in cards_controller.rb
    # the play_card method will execute because, in our routes, we mapped this url to that method with:
      #   get 'cards/:id/play/:round_id' => 'cards#play_card', as: :play_card
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
