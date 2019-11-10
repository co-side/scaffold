class CommentsController < ApplicationController
  before_action :set_blog
  before_action :set_entry
  before_action :set_comment, only: [:destroy, :approve]

  def create
    @comment = @entry.comments.build(comment_params)
    respond_to do |format|
      if @entry.save
        format.html { redirect_to [@blog, @entry], notice: 'Comment was successfully created.' }
      else
        format.html { render [@blog, @entry] }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to [@blog, @entry], notice: 'Comment was successfully destroyed.' }
    end
  end

  def approve
    @comment.update(status: 'approved')
    redirect_to [@blog, @entry], notice: 'Comment was successfully approved.'
  end

  private
    def set_blog
      @blog = Blog.find(params[:blog_id])
    end

    def set_entry
      @entry = Entry.find(params[:entry_id])
    end

    def set_comment
      set_entry
      @comment = @entry.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
