# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:book_a)
    @user = users(:user_a)
    login_as @user
  end

  test "本の一覧" do
    visit books_url
    assert_selector "h1", text: I18n.t("Books")
  end

  test "本のページ" do
    visit book_path(@book)
    assert_selector "strong", text: I18n.t("title")
    assert_selector "strong", text: I18n.t("memo")
    assert_selector "strong", text: I18n.t("author")
    assert_selector "strong", text: I18n.t("picture")
  end

  test "本を作成する" do
    visit books_url
    click_on I18n.t("New Book")

    fill_in I18n.t("title"), with: @book.title
    fill_in I18n.t("memo"), with: @book.memo
    fill_in I18n.t("author"), with: @book.author

    click_on "登録する"
    assert_text I18n.t("Book was successfully created")
  end

  test "本を編集して更新する" do
    visit edit_book_path(@book)

    fill_in I18n.t("title"), with: @book.title
    fill_in I18n.t("memo"), with: @book.memo
    fill_in I18n.t("author"), with: @book.author

    click_on "更新する"
    assert_text I18n.t("Book was successfully updated")
  end

  test "本を削除する" do
    visit books_url

    page.accept_confirm do
      click_on I18n.t("destroy"), match: :first
    end

    assert_text I18n.t("Book was successfully destroyed")
  end
end
