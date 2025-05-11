class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.decimal :amount
      t.string :description
      t.date :spendAt

      t.timestamps
    end
  end
end
