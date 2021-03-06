class CommentsController < ApplicationController
  before_action :ensure_authenticated
  before_action :set_tip

  def create
    @comment = Comment.new(comment_params)
    @comment.tip = @tip
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        @comment_was_saved = true
        flash.now.notice = t('notices.comment_created')
      else
        @comment_was_saved = false
        flash.now.alert = t('alerts.comment_creation_failed')
      end
      format.js
    end
  end

  private

    def set_tip
      @tip = Tip.find(params[:tip_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
