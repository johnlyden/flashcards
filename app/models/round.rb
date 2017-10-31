require 'pry'
class Round < ActiveRecord::Base
    belongs_to :user
    belongs_to :deck
    has_many :guesses
    attr_accessor :cards_not_answered

    after_initialize :init

    def init 
        @cards_not_answered = []
        self.deck.cards.each do |card|
            @cards_not_answered.push(card.id)
        end
        binding.pry
    end

    def update_cards(answered_card)
        @cards_not_answered = @cards_not_answered.reject do |card_id|
           card_id == answered_card.id
        end
       binding.pry
    end



end
