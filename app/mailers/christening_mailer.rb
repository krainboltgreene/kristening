class ChristeningMailer < ApplicationMailer
  default from: 'documents@kristening.me'
  def welcome_email(person, zipfile)
    @person = person
    attachments['christening.zip'] = File.read(zipfile)
    mail(to: @person.email, subject: 'Your Identity Documents')
  end
end
