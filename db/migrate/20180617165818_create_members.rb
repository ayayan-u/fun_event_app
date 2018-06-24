class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :name, null: false
      t.integer :team_id, null: false
      t.integer :game_id, null: false, default: 9
      t.integer :score, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
