# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:report_a)
    @user = users(:user_a)
    login_as @user
  end

  test "日報一覧" do
    visit reports_url
    assert_selector "h1", text: I18n.t("Reports")
  end

  test "日報ページ" do
    visit report_path(@report)
    assert_selector "strong", text: I18n.t("title")
    assert_selector "strong", text: I18n.t("body")
    assert_selector "strong", text: I18n.t("user_name")
  end

  test "日報を作成する" do
    visit reports_url
    click_on I18n.t("New report")

    fill_in I18n.t("title"), with: @report.title
    fill_in I18n.t("body"), with: @report.body

    click_on "登録する"
    assert_text I18n.t("report was successfully created")
  end

  test "日報を編集して更新する" do
    visit edit_report_path(@report)

    fill_in I18n.t("title"), with: @report.title
    fill_in I18n.t("body"), with: @report.body

    click_on "更新する"
    assert_text I18n.t("report was successfully updated")
  end

  test "日報を削除する" do
    visit reports_url

    page.accept_confirm do
      click_on I18n.t("destroy"), match: :first
    end
    assert_text I18n.t("report was successfully destroyed")
  end
end
