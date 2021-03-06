require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "john",email: "ho@2.com",password: "yeppppasdf", admin: true)
  end
  
  test "new category path" do
    sign_in_as(@user, "yeppppasdf")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: "sports"}
    end
    assert_template 'categories/index'
    assert_match "sports", response.body 
  end
  
  test "invalid name for a category" do
    sign_in_as(@user, "yeppppasdf")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, category: {name: " "}
    end
    assert_template 'categories/new'
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
  
end