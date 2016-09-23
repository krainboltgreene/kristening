require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:one)
  end

  test "should get index" do
    get people_url
    assert_response :success
  end

  test "should get new" do
    get new_person_url
    assert_response :success
  end

  test "should create person" do
    assert_difference('Person.count') do
      post people_url, params: { person: { address: @person.address, born: @person.born, city: @person.city, court_address: @person.court_address, court_location: @person.court_location, court_name: @person.court_name, dead_name: @person.dead_name, delivered_at: @person.delivered_at, dob: @person.dob, email: @person.email, rail_name: @person.rail_name, real_gender: @person.real_gender, state: @person.state, telephone: @person.telephone, zip: @person.zip } }
    end

    assert_redirected_to person_url(Person.last)
  end

  test "should show person" do
    get person_url(@person)
    assert_response :success
  end

  test "should get edit" do
    get edit_person_url(@person)
    assert_response :success
  end

  test "should update person" do
    patch person_url(@person), params: { person: { address: @person.address, born: @person.born, city: @person.city, court_address: @person.court_address, court_location: @person.court_location, court_name: @person.court_name, dead_name: @person.dead_name, delivered_at: @person.delivered_at, dob: @person.dob, email: @person.email, rail_name: @person.rail_name, real_gender: @person.real_gender, state: @person.state, telephone: @person.telephone, zip: @person.zip } }
    assert_redirected_to person_url(@person)
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete person_url(@person)
    end

    assert_redirected_to people_url
  end
end
