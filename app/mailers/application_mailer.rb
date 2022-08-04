class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("HOST_EMAIL")
  layout "mailer"
end
