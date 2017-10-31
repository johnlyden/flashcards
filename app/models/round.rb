require 'pry'
class Round < ActiveRecord::Base
    belongs_to :user
    belongs_to :deck
    has_many :guesses
    attr_accessor :old_cards

    def setup(deck)

        # self.old_cards = []

        # deck.cards.each do |card|
        #     self.old_cards.push(card.id)
        # end
        # binding.pry
        # @cards_answered_wrong = [Guess.create({card_id: @deck.cards.first, correct: true})]
    #     # push the cardsthat were anwered wrong in to this array so we can keep track fo them
    #     # @cards_answered_wrong = []
    end
end
