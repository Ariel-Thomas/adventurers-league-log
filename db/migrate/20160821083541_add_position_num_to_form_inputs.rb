class AddPositionNumToFormInputs < ActiveRecord::Migration[5.2]
  def change
    add_column :form_inputs, :position_num, :integer
  end
end
