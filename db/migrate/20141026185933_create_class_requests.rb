class CreateClassRequests < ActiveRecord::Migration
  def change
    create_table :class_requests do |t|
      t.belongs_to :user
      t.belongs_to :roster
      t.boolean :accepted, default: false
    end
  end
end
