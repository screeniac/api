class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :venue, index: true
      t.belongs_to :show, index: true
      
      t.string :status, default: 'active', index: true
      t.datetime :time, index: true
      
      t.text :details
      t.string :url
      t.string :ticket_url
      
      t.timestamps
    end
  end
end
