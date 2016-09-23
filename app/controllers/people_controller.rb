class PeopleController < InheritedResources::Base

  private

    def person_params
      params.require(:person).permit(:real_gender, :dead_name, :rail_name, :address, :city, :state, :zip, :court_address, :court_location, :court_name, :dob, :born, :telephone, :delivered_at, :email)
    end
end

