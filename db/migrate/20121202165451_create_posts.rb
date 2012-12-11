class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :tid, :null => true, :default =>nil
      t.text :text, :null => true, :default => nil

      t.timestamps
    end
  end
end
