class FixColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :likes, :account_id, :user_id
  end
end
