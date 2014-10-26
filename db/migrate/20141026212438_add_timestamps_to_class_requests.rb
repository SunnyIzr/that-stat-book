class AddTimestampsToClassRequests < ActiveRecord::Migration
  def change
    add_timestamps(:class_requests)
  end
end
