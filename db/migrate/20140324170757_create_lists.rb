class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :list_name
      t.date :deadline_date
      t.time :deadline_time

      t.timestamps
    end
  end
end
