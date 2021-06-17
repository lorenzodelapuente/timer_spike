require "test_helper"

class HttpConnectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @http_connection = http_connections(:one)
  end

  test "should get index" do
    get http_connections_url
    assert_response :success
  end

  test "should get new" do
    get new_http_connection_url
    assert_response :success
  end

  test "should create http_connection" do
    assert_difference('HttpConnection.count') do
      post http_connections_url, params: { http_connection: { clockify_api: @http_connection.clockify_api, harvest_api: @http_connection.harvest_api, toggl_api: @http_connection.toggl_api } }
    end

    assert_redirected_to http_connection_url(HttpConnection.last)
  end

  test "should show http_connection" do
    get http_connection_url(@http_connection)
    assert_response :success
  end

  test "should get edit" do
    get edit_http_connection_url(@http_connection)
    assert_response :success
  end

  test "should update http_connection" do
    patch http_connection_url(@http_connection), params: { http_connection: { clockify_api: @http_connection.clockify_api, harvest_api: @http_connection.harvest_api, toggl_api: @http_connection.toggl_api } }
    assert_redirected_to http_connection_url(@http_connection)
  end

  test "should destroy http_connection" do
    assert_difference('HttpConnection.count', -1) do
      delete http_connection_url(@http_connection)
    end

    assert_redirected_to http_connections_url
  end
end
