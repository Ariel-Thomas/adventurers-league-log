class ChangeFormInputToAdventures < ActiveRecord::Migration
  def change
    rename_table :form_inputs, :adventures
    remove_column :adventures, :type
  end
end
