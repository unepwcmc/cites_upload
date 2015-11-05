require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  setup do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in admins(:one)
  end

  test "should get index" do
    get :index
    assert_redirected_to reports_path
  end

end
