require 'test_helper'
require_relative '../../config/environment'

class PodcastServiceTest < ActiveSupport::TestCase

  def setup
      @podcast_service = Services::PodcastService.new
      @episode_service = Services::EpisodeService.new
  end

  test "Podcasts count is not 0" do
    assert @podcast_service.all.count > 0
  end

  test "Podcasts have recent episodes" do
    
    podcast = @podcast_service.podcast(1)
    episodes = @podcast_service.recent_episodes(podcast)
    assert_same(1, episodes.count)
 
  end

  test "Podcast has episodes" do
    @podcast_service.all.each do |podcast|
        assert podcast.episodes.count > 0
    end
  end

  test "Podcasts by album" do
    assert_same(1, @podcast_service.where({ :album => 'BBC'}).count)
  end

  test "Podcasts by artist" do
    assert_same(1, @podcast_service.where({ :artist => 'CBBC'}).count)
  end

  test "Podcast new" do
    assert_not_nil(@podcast_service.new)
  end

  test "Podcast save" do
    p = @podcast_service.create({:url => "http://cieclarke.com/rss", :artist => "Save", :album => "Test", :recent => 2})
    assert_not_nil(p)
    assert_same(1, @podcast_service.where({ :artist => 'Save'}).count)
    assert_not_equal(1,  @podcast_service.where({ :artist => 'NotSaved'}).count)
  end

  test "Podcast save with errors" do
    p = @podcast_service.create({:url => "htxxtp://cieclarke.com/rss", :artist => "Save", :album => "Test", :recent => "two"})
    assert_not_equal(1,  @podcast_service.where({ :artist => 'NotSaved'}).count)
  end

end
