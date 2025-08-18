module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :body, String, null: false
    field :user_id, ID, null: false
    field :comments, [CommentType], null: true
  end
end
