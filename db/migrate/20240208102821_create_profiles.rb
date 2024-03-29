class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :username
      t.text :bio 
      t.string :website
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end