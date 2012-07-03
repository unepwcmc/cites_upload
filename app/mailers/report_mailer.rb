class ReportMailer < ActionMailer::Base
  default from: "no-reply@unep-wcmc.org"

  def report_submitted report
    @report = report
    @user = report.user
    mail(:to => "#{@user.name} <#{@user.email}>", :subject => "[CITES Upload] Annual Report Submitted")
  end

  def report_submitted_admin report, url
    @report = report
    @user = report.user
    @url = url
    mail(:to => Admin.where(:receive_emails => true).map{|a| "#{a.name} <#{a.email}>"}.join(','), :subject => "[CITES Upload] #{@user.country.name} Annual Report Submitted")
  end
end
