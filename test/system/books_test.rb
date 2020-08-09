# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:book_1)
    @user = users(:user_1)
    login_as @user
  end

  test "本の一覧" do
    visit books_url
    assert_selector "h1", text: "本の一覧"
  end

  test "個別の本の詳細ページ" do
    visit book_path(@book)
    assert_selector "h1", text: "本の詳細"
  end

  test "本を作成する" do
    visit books_url
    click_on "本を追加"

    within "form.book" do
      fill_in "タイトル", with: @book.title
      fill_in "メモ", with: @book.memo
      fill_in "著者", with: @book.author
      click_button "登録する"
    end
    assert_text "本を作成しました"
  end

  test "本を編集して更新する" do
    visit edit_book_path(@book)

    within "form.book" do
      fill_in "タイトル", with: @book.title
      fill_in "メモ", with: @book.memo
      fill_in "著者", with: @book.author
      click_button "更新する"
    end
    assert_text "本を更新しました"
  end

  test "本を削除する" do
    visit books_url

    page.accept_confirm do
      click_on "削除", match: :first
    end
    assert_text "本を削除しました"
  end
end
