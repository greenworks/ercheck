require 'test_helper'

class HighestQualificationsControllerTest < ActionController::TestCase
  setup do
    @highest_qualification = highest_qualifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:highest_qualifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create highest_qualification" do
    assert_difference('HighestQualification.count') do
      post :create, highest_qualification: { description: @highest_qualification.description, name: @highest_qualification.name }
    end

    assert_redirected_to highest_qualification_path(assigns(:highest_qualification))
  end

  test "should show highest_qualification" do
    get :show, id: @highest_qualification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @highest_qualification
    assert_response :success
  end

  test "should update highest_qualification" do
    put :update, id: @highest_qualification, highest_qualification: { description: @highest_qualification.description, name: @highest_qualification.name }
    assert_redirected_to highest_qualification_path(assigns(:highest_qualification))
  end

  test "should destroy highest_qualification" do
    assert_difference('HighestQualification.count', -1) do
      delete :destroy, id: @highest_qualification
    end

    assert_redirected_to highest_qualifications_path
  end
end
