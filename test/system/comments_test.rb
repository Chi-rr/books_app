# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest <  ApplicationSystemTestCase
  setup do
    @commnet1 = comments(:commnet_1)
    @commnet2 = comments(:comment_2)
    @book = books(:book_1)
    @report = reports(:report_1)
    @user = users(:user_1)
    login_as @user
  end

  test "コメントを一覧表示する" do
    visit book_path(@book)
    visit report_path(@report)
    assert_selector "h2", text: "コメント一覧"
  end

  test "本にコメントを作成する" do
    visit book_path(@book)
    within "form.comment" do
      fill_in "コメント内容", with: @commnet1.body
      click_on "登録する"
    end
    assert_text "コメントを作成しました"
  end

  test "日報にコメントを作成する" do
    visit report_path(@report)
    within "form.comment" do
      fill_in "コメント内容", with: @commnet2.body
      click_on "登録する"
    end
    assert_text "コメントを作成しました"
  end
end
