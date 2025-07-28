class CreateApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :applications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true
      t.string :status
      t.string :resume
      t.text :cover_letter

      t.timestamps
    end
  end
end
