class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :body
      t.integer :score, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end

