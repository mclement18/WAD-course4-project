require 'test_helper'

class AccountControllerTest < ActionDispatch::IntegrationTest
  setup do
    app.default_url_options[:locale] = :en
    sign_in_as('two@extensionschool.ch')
  end

  test "should get tips owned by current user" do
    get account_tips_url
    assert_response :success
  end

  test "should get edit" do
    get account_url
    assert_response :success
  end

  test "should update current user details" do
    patch account_url, params: { user: { email: 'new@extensionschool.ch', name: 'New Name', avatar_url: 'url/to/avatar' } }
    assert_redirected_to account_url
  end
end