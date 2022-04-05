require 'test_helper'

class UserBookControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers 

  setup do
    @user_book = user_books(:one)
    get '/users/sign_in'
    sign_in users(:one)
    @user = users(:one)
    post user_session_url
  end

  test "should get new User_book" do
    get new_user_book_url
    assert_response :success
  end

   test "should create User_Book relation " do
    assert_difference('UserBook.count',1) do
    post user_books_url, params:{user_id:1,book_id:2}
  end
  assert_redirected_to root_path
end

test "should delete User_Book relation " do
    assert_difference('UserBook.count',-1) do
    delete user_book_path(@user_book.id)
  end
  assert_redirected_to root_path
end

end