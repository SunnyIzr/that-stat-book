class CreateLessonsRosters < ActiveRecord::Migration
  def change
    create_table :lessons_rosters do |t|
      t.belongs_to :lesson
      t.belongs_to :roster
      t.timestamps
    end
  end
end
