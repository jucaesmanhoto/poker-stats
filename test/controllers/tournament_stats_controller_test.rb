require "test_helper"

class TournamentStatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tournament_stats_index_url
    assert_response :success
  end

  test "should get show" do
    get tournament_stats_show_url
    assert_response :success
  end
end
