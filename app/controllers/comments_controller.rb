class CommentsController < ApplicationController
  def create
   @comment = Comment.new(comment_params)
   if @comment.save
    redirect_to prototype_path(@comment.prototype)
   else
    @prototype = @comment.prototype  #@prototypeの中身はタイトル”test”catchcopy ,concept user_idput
    @comments = @prototype.comments #＠commentsの中には該当プロトタイプにされたコメントが全部入っている
    render "prototypes/show"
  end
end
 
private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
    
  end
end