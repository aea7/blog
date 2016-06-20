require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  
  def setup
    @category = Category.create(name: "sports")
  end
  
  test 'should get category index' do
    get :index
    assert_response :success
  end
  
  test 'getting new' do
    get :new
    assert_response :success
  end
  
  test 'testing show ' do
    get(:show,{'id' => @category.id})
    assert_response :success
  end
  
  
end