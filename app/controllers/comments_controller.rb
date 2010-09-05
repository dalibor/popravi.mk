class CommentsController < ApplicationController

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.new(params[:comment])
    @comment.user = current_user if user_signed_in?

    if (user_signed_in? || verify_recaptcha(:model => @comment, :message => "Грешка со reCAPTCHA")) && @comment.save
      flash[:notice] = 'Успешно коментиравте.'
      redirect_to @commentable
    else
      @comments = @commentable.comments.find :all, :order => "created_at ASC"
      render :template => commentable_show_template
    end
  end

  private
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        if $1 == "post"
          return $1.classify.constantize.find_by_slug(value)
        else
          return $1.classify.constantize.find(value)
        end
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
end
