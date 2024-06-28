class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string     :title,         null: false
      t.text       :content,       null: false
      t.integer    :study_hours,   null: false
      t.integer    :study_minutes, null: false
      t.datetime   :start_time,    null: false
      t.references :user,          null: false, foreign_key: true

      t.timestamps
    end
  end
end
