class AddLearningModuleRefToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :learning_module, index: true
  end
end
