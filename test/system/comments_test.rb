# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest <  ApplicationSystemTestCase
  setup do
    @commnet1 = comments(:commnet_a)
    @commnet2 = comments(:comment_b)
    @book = books(:book_a)
    @report = reports(:report_a)
    @user = users(:user_a)
    login_as @user
  end

  test "コメントを一覧表示する" do
    visit book_path(@book)
    visit report_path(@report)
    assert_selector "h2", text: I18n.t("Comments")
  end

  test "コメントを作成する" do
    visit book_path(@book)
    fill_in I18n.t("body"), with: @commnet1.body

    visit report_path(@report)
    fill_in I18n.t("body"), with: @commnet2.body

    click_on "登録する"
    assert_text I18n.t("Comment was successfully created")
  end
end
