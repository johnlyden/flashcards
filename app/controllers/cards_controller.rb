class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  # this method is executed when the user goes to '/cards/:card_id/play/:round_id'
  # this executes because we mapped that URL to this action in config/routes.rb on the following line:
    # get 'cards/:id/play/:round_id' => 'cards#play_card', as: :play_card
  # this will render the :show view (views/cards/show.html.erb) which shows the card question and a form to submit an answer
  def play_card
    # we need to create an empty guess with this line, becasue an empty guess is required to set up our form to create one
    @guess = Guess.new
    # find the card based on the :id that was passed in params
    @card = Card.find(params[:id])
    # find the round based on the :round_id that was passed in
    @round = Round.find(params[:round_id]) 
    # render the show view which will show the flashcard question and form to submit an answer
    # when you enter an answer and click submit, it will post to '/guesses' which can be found in guesses_controller.rb
    render :show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:question, :answer)
    end
end
