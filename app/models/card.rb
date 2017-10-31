require 'pry'

class Card < ActiveRecord::Base
    belongs_to :deck
    has_many :guesses

    # instance method for Card that will take a guess object and check if the guess matches the card's answer
    def check_guess(guess)
        # check the guess.text against the card(self) answer
        # downcase both the guess and the answer so case won't matter
        if guess.text.downcase == self.answer.downcase
            # return true so we can store the result of the check in a variable back in our guesses_controller.rb
            return true
        else
            return false
        end
    end
end
