class CreateWeapons < ActiveRecord::Migration[6.1]
  def change
    create_table :weapons do |t|
      t.string :name
      t.string :description
      t.integer :power_base
      t.integer :power_step
      t.integer :level

      t.timestamps
    end
  end
end
