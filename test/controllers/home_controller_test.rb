require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    app.default_url_options[:locale] = :en
  end
  
  test "should get index" do
    get root_url
    assert_response :success
  end

end
