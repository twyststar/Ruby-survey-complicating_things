class MakeARespondantTable < ActiveRecord::Migration[5.1]
  def change
    create_table(:respondants) do |t|
      t.column(:user_name, :string)
      t.column(:survey_id, :integer)
      t.column(:questions, :string)
    end
  end
end
