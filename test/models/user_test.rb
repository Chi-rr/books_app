# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user1 = users(:user_1)
    @user2 = users(:user_2)
    @user3 = users(:user_3)
  end

  test "githubでログイン時、登録済みのユーザー情報を取得する" do
    auth = OmniAuth::AuthHash.new({
      uid: @user1.uid,
      provider: @user1.provider,
    })
    auth_user = User.find_for_github_oauth(auth)
    assert_equal(auth_user, @user1, "#{auth_user.name}を期待しましたが、#{@user2.name}でした")
  end

  test "githubでログイン時、登録済みのユーザー情報と照合が取れなかった場合に新規登録する" do
    auth = OmniAuth::AuthHash.new({
      uid: "123",
      provider: "github"
    })
    auth_user = User.find_for_github_oauth(auth)
    new_user = User.find_by(email: "123-github@example.com")
    assert_equal(new_user, auth_user)
  end

  test "ダミーのemailを作成できる" do
    auth = OmniAuth::AuthHash.new({
      uid: @user1.uid,
      provider: @user1.provider
    })
    email = User.dummy_email(auth)
    assert_equal("12348765-github@example.com", email)
  end

  test "他のユーザーをフォローできる" do
    assert_difference "@user2.following.count" do
      @user2.follow(@user3)
    end
    assert_equal(2, @user3.followers.count)
    assert @user2.following?(@user3)
  end

  test "他のユーザーのフォローを解除できる" do
    assert @user1.following?(@user3)
    assert_difference "@user1.following.count", -1 do
      @user1.unfollow(@user3)
    end
    assert_equal(0, @user1.following.count)
  end
end
