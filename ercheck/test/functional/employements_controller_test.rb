require 'test_helper'

class EmployementsControllerTest < ActionController::TestCase
  setup do
    @employement = employements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employement" do
    assert_difference('Employement.count') do
      post :create, employement: { date_of_joining: @employement.date_of_joining, date_of_leaving: @employement.date_of_leaving, employee_id: @employement.employee_id, employer_id: @employement.employer_id, exit_comments: @employement.exit_comments, rating: @employement.rating }
    end

    assert_redirected_to employement_path(assigns(:employement))
  end

  test "should show employement" do
    get :show, id: @employement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employement
    assert_response :success
  end

  test "should update employement" do
    put :update, id: @employement, employement: { date_of_joining: @employement.date_of_joining, date_of_leaving: @employement.date_of_leaving, employee_id: @employement.employee_id, employer_id: @employement.employer_id, exit_comments: @employement.exit_comments, rating: @employement.rating }
    assert_redirected_to employement_path(assigns(:employement))
  end

  test "should destroy employement" do
    assert_difference('Employement.count', -1) do
      delete :destroy, id: @employement
    end

    assert_redirected_to employements_path
  end
end
