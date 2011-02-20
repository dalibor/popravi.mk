module CommentsHelper
  def official_comment?(comment)
    comment.user && comment.commentable && comment.commentable.is_a?(Problem) &&
      comment.user.municipality_id == comment.commentable.municipality_id
  end
end
