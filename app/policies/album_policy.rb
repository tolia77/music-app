# frozen_string_literal: true

class AlbumPolicy
  attr_reader :user, :album

  def initialize(user, album)
    @user = user
    @album = album
  end

  def index?
    @user.admin?
  end

  def show?
    false
  end

  def create?
    @user.artist?
  end

  def update?
    (@user.artist? && @album.artists.include?(@user.artist)) || @user.admin? || @user.moderator?
  end

  def destroy?
    (@user.artist? && @album.artists.include?(@user.artist)) || @user.admin?
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
