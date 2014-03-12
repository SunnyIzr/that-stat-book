class AddDefaultToChoice < ActiveRecord::Migration
  def change
    change_column :choices, :is_correct, :boolean, :default=>false
  end
end
