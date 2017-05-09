class AddOptions < ActiveRecord::Migration[5.1]
  def change
    add_column(:questions, :opt_1, :string)
    add_column(:questions, :opt_2, :string)
    add_column(:questions, :opt_3, :string)
  end
end
