require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    app.default_url_options[:locale] = :en
  end
  
  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should get new via login_path" do
    get login_url
    assert_response :success
  end

  test "should create session" do
    post sessions_url, params: { email: 'two@extensionschool.ch', password: 'testpassword' }  
    assert_redirected_to root_url
    assert session[:user_id].present?
  end

  test "should destroy session" do
    sign_in_as 'two@extensionschool.ch'
    delete session_url(1)
    assert_redirected_to root_url
    refute session[:user_id].present?
  end

  test "should destroy session via logout_path" do
    sign_in_as 'two@extensionschool.ch'
    delete logout_url
    assert_redirected_to root_url
    refute session[:user_id].present?
  end
end
