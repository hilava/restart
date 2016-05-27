class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :country
      t.string :state
      t.string :city
      t.string :linkedin
      t.string :image
      t.text :resume
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
