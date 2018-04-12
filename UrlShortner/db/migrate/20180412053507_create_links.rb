class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.integer :user_id
      t.string :shortcode
      t.text :source_link

      t.timestamps
    end
  end
end
