class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.string :content
      t.references :anime, foreign_key: true

      t.timestamps
     
      t.index [:user_id, :anime_id], unique: true
    end
  end
end
