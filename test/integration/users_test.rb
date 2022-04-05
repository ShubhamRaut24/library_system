require 'test_helper'

class BookTestAsUserTest < ActionDispatch::IntegrationTest
   def setup
    @category = categories(:one)
    @book = books(:one)
    get '/users/sign_in'
    @user = users(:two)
    sign_in users(:two)
    post user_session_url
   end

   test "creating a book as user" do
    get books_url
    assert_response :success
    get new_book_url
    assert_response :redirect
    follow_redirect!
    assert_match "You are not authorized to perform this action.", response.body
  end

  test "Delete a book as user" do
    get books_url
    assert_response :success
    delete book_url(@book)
    assert_response :redirect
    follow_redirect!
    assert_match "You are not authorized to perform this action.", response.body
  end

  test "Edit a book as user" do
    get books_url
    assert_response :success
    get edit_book_url(@book)
    assert_response :redirect
    follow_redirect!
    assert_match "You are not authorized to perform this action.", response.body
  end

  test "rent book to user" do
  get new_user_book_url
  assert_response :success
  assert_select "table"
  post user_books_url ,params:{user_id:@user.id,book_id:@book.id}
  assert_response :redirect
  follow_redirect!
  assert_select "a", "Rent New Books"
  end

  test "Return the rented book" do
    get root_path
    assert_response :success
    assert_select "table"
    user_book = user_books(:two)
    assert_difference("UserBook.count", -1) do
    delete user_book_path(user_book.id)
    assert_response :redirect
    follow_redirect!
    assert_match "Book Successfully Removed", response.body
    end
    end

    test "creating a category as user" do
        get categories_url
        assert_response :success
        assert_select "table"
        get new_category_url
        assert_response :redirect
        follow_redirect!
        assert_difference('Category.count', 0) do
          post categories_url, params:{ category:{name:"testing" }}
          assert_response :redirect
        end
        follow_redirect!
        assert_match "You are not authorized to perform this action.", response.body
    end

    test "Edit a category as user" do
      get categories_url
      assert_response :success
      assert_select "table"
      get edit_category_url(@category)
      assert_response :redirect
      follow_redirect!
      assert_difference('Category.count', 0) do
        put category_url(@category), params:{ category:{name:"testings" }}
        assert_response :redirect
      end
      follow_redirect!
      assert_match "You are not authorized to perform this action.", response.body
  end

  test "Delete a Category as user" do
    get categories_url
    assert_response :success
    assert_select "table"
    delete category_path(@category)
    assert_response :redirect
    follow_redirect!
    assert_match "You are not authorized to perform this action.", response.body
  end
end
