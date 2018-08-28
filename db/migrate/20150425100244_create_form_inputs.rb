class CreateFormInputs < ActiveRecord::Migration[5.2]
  def change
    create_table :form_inputs do |t|
      t.string :name, null: false
      t.string :type, null: false
    end
  end
end
