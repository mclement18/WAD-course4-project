require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user must have an email" do
    user = User.new email: '',
                    password: 'password'
    refute user.valid?
  end

  test "user's email must be unique" do
    user = User.new email: 'one@extensionschool.ch',
                    password: 'password'
    refute user.valid?
  end

  test "user's email is downcased before validation" do
    user = User.new email: 'NEW@EXTENSIONSCHOOL.CH',
                    password: 'password'
    assert user.valid?
    assert_equal user.email, 'new@extensionschool.ch'
  end

  test "user must have a password" do
    user = User.new email: 'new@extensionschool.ch'
    refute user.valid?
  end

  test "user's password is encrypted" do
    user = User.create! email: 'new@extensionschool.ch',
                        password: 'password'
    refute user.password_digest.nil?
    refute_equal user.password, user.password_digest
  end

  test "user's role is 'registered' by default" do
    user = User.create! email: 'new@extensionschool.ch',
                        password: 'password'
    assert_equal user.role, 'registered'
  end

  test "user's role can only be admin or registered" do
    user_1 = User.new email: 'new1@extensionschool.ch',
                      password: 'password',
                      role: 'registered'
    user_2 = User.new email: 'new2@extensionschool.ch',
                      password: 'password',
                      role: 'admin'
    user_3 = User.new email: 'new3@extensionschool.ch',
                      password: 'password',
                      role: 'anything else'
    assert user_1.valid?
    assert user_2.valid?
    refute user_3.valid?
  end
end
