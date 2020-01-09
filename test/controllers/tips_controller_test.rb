require 'test_helper'

class TipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    app.default_url_options[:locale] = :en
    @tip = tips(:one)
  end

  test "should get index" do
    get tips_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as('two@extensionschool.ch')
    
    get new_tip_url
    assert_response :success
  end

  test "should create tip" do
    sign_in_as('two@extensionschool.ch')
    
    assert_difference('Tip.count') do
      post tips_url, params: { tip: { body: @tip.body, title: @tip.title } }
    end

    assert_redirected_to tip_url(Tip.last)
  end

  test "should show tip" do
    get tip_url(@tip)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as('one@extensionschool.ch')

    get edit_tip_url(@tip)
    assert_response :success
  end

  test "should update tip" do
    sign_in_as('one@extensionschool.ch')

    patch tip_url(@tip), params: { tip: { body: @tip.body, title: @tip.title, user_id: @tip.user_id } }
    assert_redirected_to tip_url(@tip)
  end

  test "should destroy tip" do
    sign_in_as('one@extensionschool.ch')

    assert_difference('Tip.count', -1) do
      delete tip_url(@tip)
    end

    assert_redirected_to tips_url
  end
end
