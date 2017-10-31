require 'pry'
class Round < ActiveRecord::Base
    belongs_to :user
    belongs_to :deck
    has_many :guesses
    attr_accessor :old_cards, :old

    after_initialize :init

    def init 
        @old = []
        self.deck.cards.each do |card|
            @old.push(card.id)
        end
    end

    def update_cards(answered_card)
       @old.delete(answered_card.id) 
       binding.pry
    end



end
