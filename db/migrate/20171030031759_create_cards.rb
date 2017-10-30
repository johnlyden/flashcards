class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.text :question
      t.text :answer
      t.belongs_to :deck

      t.timestamps null: false
    end
  end
end
