class DiscordSlashCommand
  class PostsCommand < DiscordSlashCommand
    extend Memoist

    def name
      "posts"
    end

    def description
      "Do a tag search"
    end

    def options
      [
        {
          name: "tags",
          description: "The tags to search",
          type: ApplicationCommandOptionType::String
        },
        {
          name: "limit",
          description: "The number of posts to show (max 10)",
          type: ApplicationCommandOptionType::Integer
        }
      ]
    end

    def call
      tags = params[:tags]
      limit = params.fetch(:limit, 3).clamp(1, 10)
      posts = Post.user_tag_match(tags, User.anonymous).limit(limit)

      respond_with(posts: posts)
    end
  end
end
