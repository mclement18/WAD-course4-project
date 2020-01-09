require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "user avatar is defaulted to AVATAR_1 when no name" do
    user = User.create! email: 'new@extensionschool.ch',
                        password: 'password'
    assert_equal default_avatar(user), AVATAR_1
  end

  test "user avatar is defaulted to AVATAR_1 when name fisrt letter > h" do
    user = User.create! email: 'new@extensionschool.ch',
                        password: 'password',
                        name: 'Bob'
    assert_equal default_avatar(user), AVATAR_1
  end

  test "user avatar is defaulted to AVATAR_2 when name fisrt letter > n" do
    user = User.create! email: 'new@extensionschool.ch',
                        password: 'password',
                        name: 'Joe'
    assert_equal default_avatar(user), AVATAR_2
  end

  test "user avatar is defaulted to AVATAR_3 when name fisrt letter > u" do
    user = User.create! email: 'new@extensionschool.ch',
                        password: 'password',
                        name: 'Steve'
    assert_equal default_avatar(user), AVATAR_3
  end

  test "user avatar is defaulted to AVATAR_4 when name fisrt letter is anything else" do
    user = User.create! email: 'new@extensionschool.ch',
                        password: 'password',
                        name: 'Yan'
    assert_equal default_avatar(user), AVATAR_4
  end

  test "pluralize_comments return the comments.count and 'comment' singular when comments.count = 0 or 1" do
    user = users(:one)
    tip_no_comment =  Tip.create! title: 'Title',
                                  body: 'body',
                                  user: user
    tip_one_comment = Tip.create! title: 'Title',
                                  body: 'body',
                                  user: user
    Comment.create! body: 'Body',
                    tip: tip_one_comment,
                    user: user
    assert_equal pluralize_comments(tip_no_comment.comments), '0 comment'
    assert_equal pluralize_comments(tip_one_comment.comments), '1 comment'
  end

  test "pluralize_comments return the comments.count and 'comments' plural when comments.count > 1" do
    Comment.create! body: 'Body',
                    tip: tips(:one),
                    user: users(:one)
    assert_equal pluralize_comments(tips(:one).comments), '2 comments'
  end

  test "pluralize_tips return the tips.count and 'comment' singular when tips.count = 0 or 1" do
    user_one_tip = users(:one)
    user_no_tip = User.create! email: 'new@extensionschool.ch',
                               password: 'password'
    assert_equal pluralize_tips(user_no_tip.tips), '0 tip'
    assert_equal pluralize_tips(user_one_tip.tips), '1 tip'
  end

  test "pluralize_tips return the tips.count and 'tips' plural when tips.count > 1" do
    Tip.create! title: 'Title',
                body: 'Body',
                user: users(:one)
    assert_equal pluralize_tips(users(:one).tips), '2 tips'
  end
end