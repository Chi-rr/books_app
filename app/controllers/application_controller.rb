# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # ログイン後
  def after_sign_in_path_for(resource)
    books_path
  end

  # ログアウト後
  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
