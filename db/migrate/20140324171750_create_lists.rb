class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.date :deadline_date
      t.time :deadline_time

      t.timestamps
    end
  end
end
