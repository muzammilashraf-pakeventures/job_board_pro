class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :slug
      t.string :subdomain
      t.boolean :active
      t.json :settings

      t.timestamps
    end
    add_index :accounts, :slug, unique: true
    add_index :accounts, :subdomain, unique: true
  end
end
