require 'test_helper'

class ExchangeControllerTest < ActionDispatch::IntegrationTest
  test "list should return array" do
    get exchange_list_url
    assert_response :success
    assert_equal(2, JSON.parse(response.body).try(:length))
  end
  test "show_info return hash" do
    get exchange_show_info_url(title: 'MyString2')
    assert_response :success
    assert_instance_of(Hash, JSON.parse(response.body))
  end
  test "markets should return array" do
    get markets_url(title: 'MyString2')
    assert_response :success
    assert_equal(1, JSON.parse(response.body).try(:length))
  end
end
