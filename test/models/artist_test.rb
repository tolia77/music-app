require "test_helper"

class ArtistTest < ActiveSupport::TestCase
  test 'should require user' do
    user = User.create(name: "test")
    assert_not user.valid?
  end
end
