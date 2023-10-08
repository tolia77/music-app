# frozen_string_literal: true

class ArtistPolicy
  attr_reader :user, :artist

  def initialize(user, artist)
    @user = user
    @artist = artist
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def update?
    @user.id == @artist.user.id || @user.moderator? || @user.admin?
  end

  def destroy?
    @user.id == @artist.user.id
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
