class EditTableForRespondant < ActiveRecord::Migration[5.1]
  def change
    remove_column(:respondants, :questions)
    add_column(:respondants, :question_id, :integer)
    add_column(:respondants, :answers, :string)
  end
end
