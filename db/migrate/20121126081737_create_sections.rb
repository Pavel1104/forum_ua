class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|

      t.string :title, :null => true, :default => nil

      t.timestamps
    end
  end
end
