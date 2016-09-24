class PeopleController < InheritedResources::Base

  def show
    @person = Person.find(params[:id])
    ActiveRecord::Base.transaction do
      DocumentMaker.enqueue(@person.id)
    end
    @person
  end

  private

    def person_params
      params.require(:person).permit(:real_gender, :dead_name, :real_name, :address, :city, :state, :zip, :court_address, :court_location, :court_name, :dob, :born, :telephone, :delivered_at, :email)
    end
end

