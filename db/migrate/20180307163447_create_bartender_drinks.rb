class CreateBartenderDrinks < ActiveRecord::Migration[5.0]
  def change
    create_join_table :bartenders, :drinks, table_name: :bartender_drinks do |t|
      t.index :bartender_id
      t.index :drink_id
      t.timestamps
    end
  end
end
