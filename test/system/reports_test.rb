# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:report_1)
    @user = users(:user_1)
    login_as @user
  end

  test "日報一覧" do
    visit reports_url
    assert_selector "h1", text: "日報一覧"
  end

  test "日報ページ" do
    visit report_path(@report)
    assert_selector "h1", text: "日報の詳細"
  end

  test "日報を作成する" do
    visit reports_url
    click_on "新規作成"

    within ".report" do
      fill_in "タイトル", with: @report.title
      fill_in "内容", with: @report.body
      click_on "登録する"
    end
    assert_text "日報を作成しました"
  end

  test "日報を編集して更新する" do
    visit edit_report_path(@report)

    within ".report" do
      fill_in "タイトル", with: @report.title
      fill_in "内容", with: @report.body
      click_on "更新する"
    end
    assert_text "日報を更新しました"
  end

  test "日報を削除する" do
    visit reports_url

    page.accept_confirm do
      click_on "削除", match: :first
    end
    assert_text "日報を削除しました"
  end
end
