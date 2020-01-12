require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tip = tips(:one)
    @comment = comments(:one)
    app.default_url_options[:locale] = :en
    sign_in_as 'two@extensionschool.ch'
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post tip_comments_url(@tip), params: { comment: { body: @comment.body } }, xhr: true
    end

    assert_response :success
  end
end
