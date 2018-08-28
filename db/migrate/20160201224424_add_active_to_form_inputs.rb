class AddActiveToFormInputs < ActiveRecord::Migration[5.2]
  def change
    add_column :form_inputs, :active, :boolean, default: true, null: false
  end
end
