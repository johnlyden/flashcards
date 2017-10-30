class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.boolean :correct, default: false
      t.belongs_to :card
      t.belongs_to :round

      t.timestamps null: false
    end
  end
end
