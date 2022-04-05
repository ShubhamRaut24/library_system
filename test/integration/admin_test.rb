require 'test_helper'

class AdminTest < ActionDispatch::IntegrationTest

  def setup
    @category = categories(:one)
    @book = books(:one)
    get '/users/sign_in'
    @user = users(:one)
    sign_in users(:one)
    post user_session_url
   end

   test "creating a book as admin" do
    get books_url
    assert_response :success
    get new_book_url
    assert_response :success
    assert_select 'h1', "Create a new book"
    assert_difference("Book.count", 1) do
    post books_url, params:{book:{name:"Great Big Lion", author:"Chryseis Knight",total:1,quantity:1},category_ids:[1,2]}
    assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Book Saved Successfully", response.body
  end

  test "update a book as admin" do
    get books_url
    assert_response :success
    get edit_book_url(@book)
    assert_response :success
    assert_select 'h1', "Edit Books"
    put book_url(@book),params:{book:{name:"Great Lion", author:"Chryseis Knight",total:2,quantity:2,status:true}}
    assert_response :redirect
    follow_redirect!
    assert_match "Book Updated Successfully", response.body
  end

  test "Delete a book as admin" do
    get books_url
    assert_response :success
    assert_difference('Book.count', -1) do
      delete book_url(@book)
      assert_response :redirect
    end
    follow_redirect!
    assert_match "All Books", response.body  
  end

  test "creating a category as admin" do
    get categories_url
    assert_response :success
    assert_select "table"
    get new_category_url
    assert_difference('Category.count', 1) do
      post categories_url, params:{ category:{name:"Availabe" }}
      assert_response :redirect
    end
    follow_redirect!
    assert_match "Category Saved Successfully", response.body
end

test "Edit a category as admin" do
  get categories_url
  assert_response :success
  assert_select "table"
  get edit_category_url(@category)
  assert_difference('Category.count', 0) do
    put category_url(@category), params:{ category:{name:"Availabe_edited" }}
    assert_response :redirect
  end
  follow_redirect!
  assert_match "Your Category was successfully updated", response.body
end

test "Delete a Category as admin" do
get categories_url
assert_response :success
assert_select "table"
delete category_path(@category)
assert_response :redirect
follow_redirect!
assert_match "Your Category was successfully Deleted", response.body
end

   

   
end
