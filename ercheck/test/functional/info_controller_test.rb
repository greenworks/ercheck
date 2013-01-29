require 'test_helper'

class InfoControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get faq" do
    get :faq
    assert_response :success
  end

  test "should get support" do
    get :support
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get terms" do
    get :terms
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

end
