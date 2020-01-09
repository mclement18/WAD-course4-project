require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "comment must have body" do
    comment = Comment.new user: users(:one),
                          tip: tips(:one)
    refute comment.valid?
  end

  test "comment must have user" do
    comment = Comment.new body: 'New comment',
                          tip: tips(:one)
    refute comment.valid?
  end

  test "comment must have tip" do
    comment = Comment.new body: 'New comment',
                          user: users(:one)
    refute comment.valid?
  end
end
