class Person < ApplicationRecord
  def send_documents
    zip_file = Document::California.create_zip(self.as_json.symbolize_keys!)
    ChristeningMailer.welcome_email(self,zip_file).deliver
  end
end
