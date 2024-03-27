class CreateUserForums < ActiveRecord::Migration[7.1]
  def change
    create_table :user_forums do |t|
      t.references :user, null: false, foreign_key: true
      t.references :forum, null: false, foreign_key: true

      t.timestamps
    end
  end
end
