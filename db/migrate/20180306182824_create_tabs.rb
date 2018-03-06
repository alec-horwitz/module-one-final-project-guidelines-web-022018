class CreateTabs < ActiveRecord::Migration[5.0]
  def change
    create_table :tabs do |t|
      t.integer :customer_id
      t.integer :bartender_id
      t.float :amount_due
      t.integer :drinks_purchased
      t.timestamps
    end
  end
end
