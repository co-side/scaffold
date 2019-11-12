class CommentMailer < ApplicationMailer
  def send_when_create(comment)
    @comment = comment
    mail
  end
end
