class LikeController < ApplicationController
    before_action :authenticate_user!

    def toggle_like(blog_post_id, user_id)
        # Find or create a like entry
        like = Like.find_or_initialize_by(blog_post_id: blog_post_id, user_id: user_id)

        if like.new_record?
            like.save
            render json: { message: 'Liked successfully' }, status: :created
        else
            like.destroy
            render json: { message: 'Unliked successfully' }, status: :ok
        end
    end

end
