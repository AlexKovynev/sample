class CreateExchanges < ActiveRecord::Migration[5.2]
  def change
    create_table :exchanges do |t|
      t.string :title
      t.string :uid
      t.jsonb :data

      t.timestamps
    end
    add_index :exchanges, :title, unique: true
    add_index :exchanges, :uid
  end
end


