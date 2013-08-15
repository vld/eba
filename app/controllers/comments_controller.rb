class CommentsController < ApplicationController
  before_filter :current_issue
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.manager = current_manager
    if @comment.save
      redirect_to @issue, :notice => "Comment created"
    else
      redirect_to @issue, :error => "Comment error"
    end
  end

  def current_issue
    @issue = Issue.find(params[:issue_id])
  end
end
