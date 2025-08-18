class MakeUserIdNotNullInPosts < ActiveRecord::Migration[7.2]
  def change
    change_column_null :posts, :user_id, false
  end
end
