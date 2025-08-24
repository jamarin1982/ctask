class ApplicationMailer < ActionMailer::Base
  default from: "no_reply@c_task.com"
  layout "mailer"
end
