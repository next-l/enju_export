class CreateExportFileTransitions < ActiveRecord::Migration
  def change
    create_table :export_file_transitions do |t|
      t.string :to_state
      t.text :metadata, default: "{}"
      t.integer :sort_key
      t.integer :export_file_id
      t.timestamps
    end

    add_index :export_file_transitions, :export_file_id
    add_index :export_file_transitions, [:sort_key, :export_file_id], unique: true
  end
end
