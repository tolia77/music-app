# frozen_string_literal: true

class UserPolicy
  attr_reader :user, :user2

  def initialize(user, user2)
    @user = user
  end

  def index?
    @user.admin?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
