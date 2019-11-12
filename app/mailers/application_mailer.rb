class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@example.com'
  default to: 'admin@example.com'
  default subject: '新しいコメントが投稿されました'
  layout 'mailer'
end
