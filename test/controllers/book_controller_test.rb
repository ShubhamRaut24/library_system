require 'test_helper'

class BookControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers 

  setup do
    @book = books(:one)
    get '/users/sign_in'
    sign_in users(:one)
    @user = users(:one)
    post user_session_url
  end


  test "should get all books" do
    get books_url
    assert_response :success
  end 
  
  test "should show book  " do
    get @book_url
    assert_response :success
  end 

  test "should get book new" do
    get new_book_url
    assert_response :success
  end

  test "should create book " do
    assert_difference('Book.count',1) do
      post books_url, params:{ book:{name:"The Great lion", author:"Mark Coll",total:1,quantity:1}}
    end
    assert_redirected_to books_url
  end

  test "should delete book" do
    assert_difference('Book.count', -1) do
      delete book_url(@book)
    end
    assert_redirected_to books_url
  end

  test "should NOT save the book" do
    assert_difference('Book.count',0) do
      post books_url, params:{ book:{name:"T", author:"Mark Coll",total:nil,quantity:1}}

    end
    assert_template  "new"
  end

  test "should NOT update the book, Must render edit template" do
      put book_url(@book), params:{ book:{name:"T", author:"Mark Coll",total:nil,quantity:1}}
    assert_template  "edit"
  end


   

   
     
 


end
