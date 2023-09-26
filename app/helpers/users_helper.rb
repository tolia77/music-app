# frozen_string_literal: true

module UsersHelper
  def check_user(user)
    unless user == current_user
      head 403
    end
  end
end
