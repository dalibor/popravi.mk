class CommentsController < ApplicationController

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.new(params[:comment])
    @comment.user = current_user if user_signed_in?

    if (user_signed_in? || verify_recaptcha(:model => @comment, :message => "Грешка со reCAPTCHA")) && @comment.save
      flash[:notice] = 'Успешно коментиравте.'
      redirect_to commentable_path(@commentable)
    else
      @comments = @commentable.comments.find :all, :order => "created_at ASC"
      render :template => commentable_show_template
    end
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

    def commentable_show_template
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return "#{$1.pluralize}/show"
        end
      end
      nil
    end

    def commentable_path(commentable)
      if commentable.is_a?(Post)
        post_path(commentable.slug)
      else
        commentable
      end
    end
end
