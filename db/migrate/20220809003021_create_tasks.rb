class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, limit: 100, null: false
      t.string :status, limit: 100

      t.timestamps
    end
  end
end
