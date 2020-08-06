# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:user_a)
    login_as @user
  end

  # ユーザー一覧を表示
  test "ユーザー一覧" do
    visit users_path
    assert_selector "h1", text: "全てのユーザー"
  end

  # ユーザーページ表示
  test "ユーザーページ表示" do
    visit user_path(@user)
    assert_selector "h1", text: "マイページ"
  end
end
