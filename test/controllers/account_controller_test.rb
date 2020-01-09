require 'test_helper'

class AccountControllerTest<ActionDispatch::IntegrationTest
  setup do
    app.default_url_options[:locale] = :en
    @user = users(:one)
    sign_in_as('one@extensionschool.ch')
  end

  test "should get tips owned by current user" do
    get account_tips_url
    assert_response :success
  end
end