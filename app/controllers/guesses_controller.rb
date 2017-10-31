require 'pry'

class GuessesController < ApplicationController
  before_action :set_guess, only: [:show, :edit, :update, :destroy]

  # POST /guesses
  # when you answer a question - this is where the form POSTs to
  # this method will create a guess object with the information we need, then it will check the guess, and if the guess is correct it will remove the card from our array of cards we need to answer
  def create
    # create the guess object based on the params passed form the form, i.e the text of the guess, the user_id and the card_id
    # we are able to find the @card and the @round becuase we passed their id's as hidden fields in the form that was submitted
    @guess = Guess.create(guess_params)
    # find the card the guess is associated with
    @card = Card.find(guess_params[:card_id]);
    # find the round the guess is associated with
    @round = Round.find(guess_params[:round_id])

    respond_to do |format|
      # calling the card instance method 'check_guess' and passing it the @guess object
      # this method will compare the guess to the card's answer and return true if correct, false if incorrect
      # you can find this check_guess method in models/card.rb
      result = @card.check_guess(@guess)
      
      # if the result of the guess was true, that means it was correct
      if result == true
        # the guess was correct, so update the "correct" attribute on the guess to true (it was false by default)
        @guess.update_attributes(correct: true)
        # delete the card_id that was answered correctly from our array of cards_not_answered, which is stored in the session
        # if we delete the card_id of the card that was answered, it will no longer be showin in the game
        session[:cards_not_answered].delete(@card.id)

        # this is checking if there aren't any cards left in the cards_not_answered
        # if its greater than 0, then there are still cars left to anser
        if session[:cards_not_answered].length > 0
          # randomly select a card_id from the cards_not_answered array
          next_card_id = session[:cards_not_answered].sample
          # redirect to play that card, using the variable next_card_id that we just made
          # this is redirecting to the /cards/:id/play/:round_id route, which will trigger the play_card method.  the play_card method will render the view with the new card's question and a submit form to anser it
          format.html {redirect_to "/cards/#{next_card_id}/play/#{@round.id}"}
        else
          # if there aren't any cards left in the cards_not_answered array then the game must be over - we have answered all the cards
          # in this case, we should redirect to the results route which will show our results
          format.html {redirect_to "/rounds/#{@round.id}/results"}
        end
      else
        # down here is the block for if the guess was not correct
        # if the guess was incorrect, we simply pick a new card_id from the cards_not_answered array that is stored in the session
        next_card_id = session[:cards_not_answered].sample
        # with that next_card_id we can redirect to /cards/:id/play/:round_id route, which will trigger the play_card method which will render the view with the next card's question and a submit form to answer
        format.html {redirect_to "/cards/#{next_card_id}/play/#{@round.id}"} 
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guess
      @guess = Guess.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guess_params
      params.require(:guess).permit(:text, :card_id, :round_id)
    end
end
