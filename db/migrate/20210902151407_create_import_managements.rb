class CreateImportManagements < ActiveRecord::Migration[6.1]
  def change
    create_table :import_managements do |t|
      t.integer :status, default: 0
      t.string :description
      t.string :to
      t.string :from

      t.timestamps
    end
  end
end
