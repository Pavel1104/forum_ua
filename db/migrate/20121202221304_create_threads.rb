class CreateThreads < ActiveRecord::Migration
  def change
    create_table :threads do |t|
      t.integer :bid, :null => true, :default =>nil
      t.string :title, :null => true, :default => nil

      t.timestamps
    end
  end
end
