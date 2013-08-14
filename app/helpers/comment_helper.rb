module CommentHelper
  def comments_on_page(commentable, comments, page)
    if comments.blank? #creating or destroying a commnet(within comment controller)
      c = commentable.root_comments.order('created_at DESC').page(page)

      if c.blank? && page.to_i > 1 #when destroying a comment and losing a page
        c = commentable.root_comments.order('created_at DESC').page(page.to_i-1)
      end

      return c
    else
      return comments
    end
  end
end
