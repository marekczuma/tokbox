class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.references :user, index: true, foreign_key: true
      t.text :desc
      t.string :status
      t.string :tokbox_session_id

      t.timestamps null: false
    end
  end
end
