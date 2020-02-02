class AddCountToPosts < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :total_likes_count, :integer, default: 0
  end
end
