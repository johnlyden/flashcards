require 'pry'
class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :edit, :update, :destroy]

  # this method will render a view that shows the user's results from playing the flashcard deck
  # this method is triggered by hitting the following route in config/routes.rb:
  # get 'rounds/:id/results' => 'rounds#show_results', as: :show_results
  def show_results
    # find the round we just played so we can pull information from it, i.e. guesses and the how many cards were in the deck
    @round = Round.find(params[:id])
    # use the round to calculate the score, using cards and guesses.  this computes the average.  i.e. (# of cards / # of guesses)
    # adding .to_f to both of these numbers.  this will make them into decimals, i.e. 5 => 5.0
    # ruby only gives you back a decimal if you divide decimals.
    # 5/4 => 1  but 5.0/4.0 => 1.25
    @score = @round.deck.cards.length.to_f / @round.guesses.length.to_f * 100 
    # render the results view which will show your score. found in 'views/rounds/results'
    render "rounds/results"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @round = Round.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def round_params
      params.fetch(:round, {})
    end
end
