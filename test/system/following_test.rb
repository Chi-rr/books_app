# frozen_string_literal: true

require "application_system_test_case"

class FollowingTest < ApplicationSystemTestCase
  setup do
    @user1 = users(:user_1)
    @user2 = users(:user_2)
    @user3 = users(:user_3)
    login_as @user1
  end

  test "フォロー一覧" do
    visit user_followings_path(@user1)
    assert_selector "h2",  text: "フォロー"
  end

  test "フォロワー一覧" do
    visit user_followers_path(@user1)
    assert_selector "h2", text: "フォロワー"
  end

  test "フォローの状態" do
    visit user_path(@user2)

    assert_difference "@user1.following.count" do
      click_button "フォローする"
      until find_button("commit").value == "フォロー解除"; end
    end
    assert_equal(1, @user2.followers.count)
  end

  test "アンフォロー状態" do
    visit user_path(@user3)

    assert_difference "@user1.following.count", -1 do
      click_button "フォロー解除"
      until find_button("commit").value == "フォローする"; end
    end
    assert_equal(0, @user3.followers.count)
  end

  test "個人ページの統計表示" do
    visit user_path(@user1)
    assert has_link?("1 フォロワー")
    assert has_link?("1 フォロー")
  end
end
