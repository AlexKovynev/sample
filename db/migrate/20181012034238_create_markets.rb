class CreateMarkets < ActiveRecord::Migration[5.2]
  def change
    create_table :markets do |t|
      t.string :uid
      t.jsonb :data
      t.references :exchange, foreign_key: true

      t.timestamps
    end
    add_index :markets, %I[uid exchange_id], unique: true
  end
end
