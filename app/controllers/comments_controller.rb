class CommentsController < ApplicationController

  def create
    @problem = Problem.find(params[:problem_id])
    @comment = @problem.comments.new(params[:comment])
    @comment.user = current_user if user_signed_in?

    if @comment.save
      flash[:notice] = 'Успешно коментиравте.'
      redirect_to problem_url(@problem)
    else
      @comments = @problem.comments.find :all, :order => "created_at ASC"
      render :template => "problems/show"
    end
  end
end
