class CreateMagicItems < ActiveRecord::Migration[5.2]
  def change
    create_table :magic_items do |t|
      t.string  :name
      t.integer :log_entry_id
    end
  end
end
