require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "Example user", 
                     email: "user@example.com",
                     password: "foobar",
                     password_confirmation: "foobar")
  end

  test "user should valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email should accept valid address" do
    valid_addresses = %W(foo@bar.com foo@bar.CoM foo@45h.org
                         gy@kus.cn ko@sdh-sd.jp)

    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email should reject invalid address" do
    invalid_address = %w[user@example,com user_at_foo.org user.name@example.
                               foo@bar_baz.com foo@bar+baz.com]

    invalid_address.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should not be valid"
    end
  end

  test "email address should be unique" do
    @user.save
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    assert_not duplicate_user.valid?

  end

  test "email address should be saved as-case" do
    uppercase_email = "FOO@BAR.com"
    @user.email = uppercase_email
    @user.save
    assert_equal uppercase_email.downcase, @user.reload.email 
  end
  
  test "password should be present(nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have minimun length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end


  
end
