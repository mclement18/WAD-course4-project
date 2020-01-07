require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    app.default_url_options[:locale] = :en
  end
  
  test "should get new" do
    get sessions_new_url
    assert_response :success
  end

end
