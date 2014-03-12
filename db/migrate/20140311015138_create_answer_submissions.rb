class CreateAnswerSubmissions < ActiveRecord::Migration
  def change
    create_table :answer_submissions do |t|

      t.timestamps
    end
  end
end
