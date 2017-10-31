class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def play_card
    @guess = Guess.new
    @card = Card.find(params[:id])
    @round = Round.find(params[:round_id]) 
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
