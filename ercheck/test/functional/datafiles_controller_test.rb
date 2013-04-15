require 'test_helper'

class DatafilesControllerTest < ActionController::TestCase
  setup do
    @datafile = datafiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:datafiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create datafile" do
    assert_difference('Datafile.count') do
      post :create, datafile: { name: @datafile.name, records: @datafile.records, status: @datafile.status }
    end

    assert_redirected_to datafile_path(assigns(:datafile))
  end

  test "should show datafile" do
    get :show, id: @datafile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @datafile
    assert_response :success
  end

  test "should update datafile" do
    put :update, id: @datafile, datafile: { name: @datafile.name, records: @datafile.records, status: @datafile.status }
    assert_redirected_to datafile_path(assigns(:datafile))
  end

  test "should destroy datafile" do
    assert_difference('Datafile.count', -1) do
      delete :destroy, id: @datafile
    end

    assert_redirected_to datafiles_path
  end
end
