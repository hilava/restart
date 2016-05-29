class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :category
      t.string :title
      t.text :description
      t.string :email
      t.string :phone_number
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
