module Types
  class QueryType < Types::BaseObject
    field :posts, [PostType], null: false
    field :post, PostType, null: false do
      argument :id, ID, required: true
    end

    def posts
      Post.all
    end

    def post(id:)
      Post.find(id)
    end
  end
end
