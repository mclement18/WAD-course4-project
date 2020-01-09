require 'test_helper'

class RolesHelperTest < ActionView::TestCase
  attr_accessor :current_user

  test "current_user_role return 'anonymous' when not logged in" do
    logged_in?(false)
    assert_equal current_user_role, 'anonymous'
  end

  test "current_user_role return the logged in user role" do
    logged_in?(true)
    self.current_user = users(:one)
    assert_equal current_user_role, 'admin'
    self.current_user = users(:two)
    assert_equal current_user_role, 'registered'
  end

  test "registered user can edit owned tips" do
    self.current_user = users(:two)
    assert can_edit?(tips(:two))
  end

  test "admin user can edit other's tips" do
    self.current_user = users(:one)
    assert can_edit?(tips(:two))
  end

  test "registered user cannot edit other's tips" do
    self.current_user = users(:two)
    refute can_edit?(tips(:one))
  end

  private

  # Emulate ApplicationController#logged_in?
  def logged_in?(value = nil)
    return @answer if value.nil?
    @answer = value
  end
end