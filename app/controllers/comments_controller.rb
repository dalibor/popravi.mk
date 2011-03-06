class CommentsController < ApplicationController

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.new(params[:comment])
    @comment.user = current_user if user_signed_in?

    if (user_signed_in? || verify_recaptcha(:model => @comment, :message => t('g.captcha_error'))) && @comment.save
      flash[:notice] = t('comments.success')
    else
      flash[:error] = @comment.errors.full_messages[0]
    end

    redirect_to commentable_path(@commentable)
  end

  private

    def find_commentable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end

    def commentable_path(commentable)
      if commentable.is_a?(Post)
        if commentable.user.is_moderator?
          municipality_post_path(commentable.user.municipality.slug, commentable.slug)
        else
          post_path(commentable.slug)
        end
      else
        commentable
      end
    end
end
