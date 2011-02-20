class MunicipalityMailer < ActionMailer::Base
  default :from => "info@popravi.com"

  def send_problems(municipality, problems)
    @municipality = municipality
    @problems     = problems
    mail(:to => municipality.users.all.map(&:email).join(", "),
         :subject => "[PopraviMK] Recently reported problems")
  end
end
