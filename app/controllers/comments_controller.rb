class CommentsController < ApplicationController
  before_filter :require_user
  
  def create
    type = params[:comment][:commentable_type]
    
    @commentable = type.constantize.find(params[:comment][:commentable_id])
    
    parent_id = params[:comment][:parent_id]
    
    comment = Comment.build_from(@commentable, current_user.id, params[:comment][:body])

    Comment.transaction do
      comment.save
      comment.move_to_child_of(parent_id) if parent_id.present?
    end
    
    render "#{ comment.commentable_type }s/update_comments"
  end
  
  
  def destroy
    comment = Comment.find(params[:id])
    @commentable = comment.commentable
    
    comment.destroy unless comment.has_children?
    
    render "#{ comment.commentable_type }s/update_comments"
  end
end
