require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should sign up' do
    sign_up('test', 'test@test.com', 'test1234')
    assert_response :success
  end

  test 'should log in' do
    sign_up('test', 'test@test.com', 'test1234')
    session = sign_in('test@test.com', 'test1234')
    assert_response :success
  end

  test 'should log out' do
    sign_up('test', 'test@test.com', 'test1234')
    session = sign_in('test@test.com', 'test1234')
    log_out(session["Authorization"])
    assert_response :success
  end
end
