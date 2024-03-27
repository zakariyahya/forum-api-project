class CreateArtists < ActiveRecord::Migration[7.1]
  def change
    create_table :artists do |t|
      t.string :first_name
      t.string :last_name
      t.string :genre

      t.timestamps
    end
  end
end
