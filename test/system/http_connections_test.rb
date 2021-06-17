require "application_system_test_case"

class HttpConnectionsTest < ApplicationSystemTestCase
  setup do
    @http_connection = http_connections(:one)
  end

  test "visiting the index" do
    visit http_connections_url
    assert_selector "h1", text: "Http Connections"
  end

  test "creating a Http connection" do
    visit http_connections_url
    click_on "New Http Connection"

    fill_in "Clockify api", with: @http_connection.clockify_api
    fill_in "Harvest api", with: @http_connection.harvest_api
    fill_in "Toggl api", with: @http_connection.toggl_api
    click_on "Create Http connection"

    assert_text "Http connection was successfully created"
    click_on "Back"
  end

  test "updating a Http connection" do
    visit http_connections_url
    click_on "Edit", match: :first

    fill_in "Clockify api", with: @http_connection.clockify_api
    fill_in "Harvest api", with: @http_connection.harvest_api
    fill_in "Toggl api", with: @http_connection.toggl_api
    click_on "Update Http connection"

    assert_text "Http connection was successfully updated"
    click_on "Back"
  end

  test "destroying a Http connection" do
    visit http_connections_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Http connection was successfully destroyed"
  end
end
