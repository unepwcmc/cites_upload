class UserMailer < ActionMailer::Base
  default from: "no-reply@unep-wcmc.org"

  def user_approved user
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "[CITES Upload] Membership approved")
  end
end
