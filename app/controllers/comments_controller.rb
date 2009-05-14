class CommentsController < ApplicationController
  #This is a virtual comment manager. There is no user detection, no session
  before_filter :load_post

  #This is our entry point, I'm just going to display a factice post to comment
  def index
    @comments = Comment.all
    respond_to do |format|
      format.html #we only respond to the html request
      format.js { }
    end
  end

  def new
    @comment = Comment.new
    if !request.xhr?
      @comments = Comment.all
    end

    respond_to do |format|
      format.html
      format.js {render :layout => false}
    end
  end

  def create
    @comment = Comment.create(params[:comment])
    respond_to do |format|
      format.html { redirect_to comments_path() }
      format.js {render :layout => false}
    end
  end

  #This is not a "normal" update, I'll use this one to add points to the comment
  def update

  end

  def delete

  end

  protected

  def load_post
   @post = "This is a factice post, I hope you like it. Just comment on the bottom!"
  end
end

