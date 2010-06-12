class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :body
      t.date :published_at
      t.string :url
      t.string :email
      t.string :name
      t.boolean :spam
      t.boolean :published

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
