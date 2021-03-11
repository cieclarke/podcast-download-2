require 'test_helper'
require_relative '../../config/environment'

class ServiceTest < ActiveSupport::TestCase
    def setup
        @service = Services::PodcastService.new
    end
  test "Podcasts count is not 0" do
    assert @service.all.count > 0
  end

  test "Podcast has episodes" do
    @service.all.each do |podcast|
        assert @service.recent_episodes(podcast).count > 0
    end
  end

  test "Podcasts by album" do
    assert_same(1, @service.by_album('BBC').count)
  end

  test "Podcasts by artist" do
    assert_same(1, @service.by_artist('CBBC').count)
  end
end
