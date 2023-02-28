class CreateSleepRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :sleep_records do |t|
      t.references :user, foreign_key: true
      t.datetime :clock_in_at
      t.datetime :clock_out_at
      t.integer :sleep_duration

      t.timestamps
    end

    add_index :sleep_records, [:user_id, :clock_in_at]
  end
end
