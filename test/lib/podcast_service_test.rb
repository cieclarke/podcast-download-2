require 'test_helper'
require_relative '../../config/environment'

class PodcastServiceTest < ActiveSupport::TestCase

  def setup
      @service = Services::PodcastService.new
  end

  test "Podcasts count is not 0" do
    assert @service.all.count > 0
  end

  test "Podcasts have recent episodes" do
    
    podcast = @service.podcast(1)
    assert_same(1, podcast.recent_episodes.count)
 
  end

  test "Podcast has episodes" do
    @service.all.each do |podcast|
        assert podcast.recent_episodes.count > 0
    end
  end

  test "Podcasts by album" do
    assert_same(1, @service.where({ :album => 'BBC'}).count)
  end

  test "Podcasts by artist" do
    assert_same(1, @service.where({ :artist => 'CBBC'}).count)
  end

  test "Podcast new" do
    assert_not_nil(@service.new)
  end

  test "Podcast save" do
    p = @service.save_podcast({:url => "http://cieclarke.com/rss", :artist => "Save", :album => "Test", :recent => 2})
    assert_not_nil(p)
    assert_same(1, @service.where({ :artist => 'Save'}).count)
    assert_not_equal(1,  @service.where({ :artist => 'NotSaved'}).count)
  end

  test "Podcast save with errors" do
    p = @service.save_podcast({:url => "http://cieclarke.com/rss", :artist => "Save", :album => "Test", :recent => "two"})
    assert_not_nil(p[:errors], p[:errors].full_messages)
    assert_not_equal(1,  @service.where({ :artist => 'NotSaved'}).count)
  end

  test "Episode saves file" do
    #base_folder = Rails.configuration.audio['base_folder'].nil? ? '/' : Rails.configuration.audio['base_folder']
    #episode = @service.all.first
    #@service.save_to_file(episode, base_folder)
    #assert true
  end

end
