class AddPositionNumToFormInputs < ActiveRecord::Migration
  def change
    add_column :form_inputs, :position_num, :integer
  end
end
