class AddCountDefaultToPosts < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :total_comments_count, :integer, default: 0
  end
end
