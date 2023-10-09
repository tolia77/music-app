# frozen_string_literal: true

class SongPolicy
  attr_reader :user, :song

  def initialize(user, song)
    @user = user
    @song = song
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    @user.artist?
  end

  def update?
    (@user.artist? && @song.artists.include?(@user.artist)) || @user.admin? || @user.moderator?
  end

  def destroy?
    (@user.artist? && @song.artists.include?(@user.artist)) || @user.admin?
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
