class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :sid, :null => true, :default =>nil
      t.string :title, :null => true, :default => nil

      t.timestamps
    end
  end
end
