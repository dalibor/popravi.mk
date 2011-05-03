class MunicipalityMailer < ActionMailer::Base
  MAIL_PREFIX = '[PopraviMK]'
  default :from => "info@popravi.com"

  def send_problems(municipality, problems)
    @municipality = municipality
    @problems     = problems
    mail(:to => municipality.users.all.map(&:email).join(", "),
         :subject => "#{MAIL_PREFIX} #{I18n.t('mailer.send_problems_subject')}")
  end
end
