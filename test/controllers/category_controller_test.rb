require 'test_helper'

class CategoryControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers 

  setup do
    @category = categories(:one)
    get '/users/sign_in'
    sign_in users(:one)
    @user = users(:one)
    post user_session_url
  end


  test "should get all categories" do
    get categories_path
    assert_response :success
  end 
  
  test "should show category  " do
    get @category_url
    assert_response :success
  end 

  test "should get category new" do
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count',1) do
      post categories_url, params:{ category:{name:"Thriller"}}
    end
    assert_redirected_to categories_url
  end

  test "should delete category" do
    assert_difference('Category.count', -1) do
      delete category_url(@category)
    end

    assert_redirected_to categories_url
  end
  
  test "should NOT save the Category" do
    assert_difference('Category.count',0) do
      post categories_url, params:{ category:{name:"T"}}
    end
    assert_template  "new"
  end

  test "should NOT update the category, Must render edit template" do
    put category_url(@category), params:{ category:{name:"T"}}
  assert_template  "edit"
end
   

   
     
 


end
