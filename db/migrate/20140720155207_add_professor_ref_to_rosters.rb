class AddProfessorRefToRosters < ActiveRecord::Migration
  def change
    add_reference :rosters, :professor, index: true
  end
end
