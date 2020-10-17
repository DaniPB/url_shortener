class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :address
      t.string :short
      t.integer :visits, null: false, default: 0

      t.timestamps
    end
  end
end
