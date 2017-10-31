require 'pry'

class Card < ActiveRecord::Base
    belongs_to :deck
    has_many :guesses

    def check_guess(guess)
        # check the guess.text against the card(self) answer
        if guess.text.downcase == self.answer.downcase
            guess.update_attributes(correct: true);
            return true
        else
            return false
        end
    end
end
