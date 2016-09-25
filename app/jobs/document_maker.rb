#!/usr/bin/env ruby

class DocumentMaker < Que::Job
  def run(person_id)
    person = Person.find(person_id)
    if person.delivered_at == nil
      ActiveRecord::Base.transaction do
        person.send_documents
        person.delivered_at = Time.now
        person.save!
      end
    end
  end
end
