class CommentsController < ApplicationController
  before_filter :require_user
  
  def create
    type = params[:comment][:commentable_type]
    
    @commentable = type.constantize.find(params[:comment][:commentable_id])
    @page = params[:page]
    
    parent_id = params[:comment][:parent_id]
    
    @comment = Comment.build_from(@commentable, current_user.id, params[:comment][:body])

    Comment.transaction do
      @comment.save
      @comment.move_to_child_of(parent_id) if parent_id.present?
    end
    
    render "#{ @comment.commentable_type }s/comments"
  end
  
  
  def destroy
    comment = Comment.find(params[:id])
    @commentable = comment.commentable
    @page = params[:page]
    
    comment.destroy unless comment.has_children?
    
    render "#{ comment.commentable_type }s/comments"
  end
end
