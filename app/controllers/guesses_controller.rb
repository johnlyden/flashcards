require 'pry'

class GuessesController < ApplicationController
  before_action :set_guess, only: [:show, :edit, :update, :destroy]

  # GET /guesses
  # GET /guesses.json
  def index
    @guesses = Guess.all
  end

  # GET /guesses/1
  # GET /guesses/1.json
  def show
  end

  # GET /guesses/new
  def new
    @guess = Guess.new
  end

  # GET /guesses/1/edit
  def edit
  end

  # POST /guesses
  # POST /guesses.json
  def create
    @guess = Guess.new(guess_params)
    @card = Card.find(guess_params[:card_id]);
    @round = Round.find(guess_params[:round_id])

    respond_to do |format|
      if @guess.save
        # check if the guess was correct - wil return true or false and save it in result
        result = @card.check_guess(@guess)
        
        if result == true
          #guess was correct
          #remove the card from the @round.cards
          # binding.pry
          @round.update_cards(@card)
          # binding.pry
          if @round.cards_not_answered.length > 0
            next_card_id = @round.cards_not_answered.sample
            format.html {redirect_to "/cards/#{next_card_id}/play/#{@round.id}"}
          #pick a random card_id from the @round.cards and redirect there
          else
            format.html {redirect_to @cards}
          end
        end
      else
        format.html { render :new }
        format.json { render json: @guess.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guesses/1
  # PATCH/PUT /guesses/1.json
  def update
    respond_to do |format|
      if @guess.update(guess_params)
        format.html { redirect_to @guess, notice: 'Guess was successfully updated.' }
        format.json { render :show, status: :ok, location: @guess }
      else
        format.html { render :edit }
        format.json { render json: @guess.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guesses/1
  # DELETE /guesses/1.json
  def destroy
    @guess.destroy
    respond_to do |format|
      format.html { redirect_to guesses_url, notice: 'Guess was successfully destroyed.' }
      format.json { head :no_content }
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
