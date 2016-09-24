#!/usr/bin/env ruby

class DocumentMaker < Que::Job
  def run(person_id)
    person = Person.find(person_id)
    ActiveRecord::Base.transaction do
      person.send_documents
    end
  end
end
