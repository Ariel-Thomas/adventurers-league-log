class AddActiveToFormInputs < ActiveRecord::Migration
  def change
    add_column :form_inputs, :active, :boolean, default: true, null: false
  end
end
