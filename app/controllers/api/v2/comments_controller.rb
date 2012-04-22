class Api::V2::CommentsController < Api::V2::BaseController
  before_filter :load_problem

  def index
    comments = @problem.comments.find(:all, :include => :user)

    @comments = []
    comments.each do |comment|
      @comments << {
        :user => comment.commenter_name,
        :content => comment.content,
        :created_at => comment.created_at.to_s(:rfc822)
      }
    end

    render_json(@comments)
  end

  def create
    comment = @problem.comments.new(:name => params[:name],
                                    :email => params[:email],
                                    :content => params[:content])
    comment.user = user_from_session

    if comment.save
      render_json({ :status => 'ok',
                    :comment => {
                      :user => comment.commenter_name,
                      :content => comment.content,
                      :created_at => comment.created_at.to_s(:rfc822)
                    }
                  })
    else
      render_json({ :status => 'error' })
    end
  end

  private
    def load_problem
      @problem = Problem.find(params[:problem_id])
    end
end
