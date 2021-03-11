# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Podcast.create(
[
    {
      url: 'https://feeds.acast.com/public/shows/5e7b777ba085cbe7192b0607',
      album: 'The Bugle',
      artist: 'The Bugle',
      recent: 3
    },
    {
      url: 'https://feeds.npr.org/510289/podcast.xml',
      album: 'Planet Money',
      artist: 'NPR',
      recent: 3
    },
    {
      url: 'https://podcasts.files.bbci.co.uk/p07mdbhg.rss',
      album: 'You\'re Dead To Me',
      artist: 'BBC',
      recent: 3
    },
    {
      url: 'https://podcasts.files.bbci.co.uk/p02pc9pj.rss',
      album: 'Friday Night Comedy ',
      artist: 'BBC',
      recent: 2
    },
    {
      url: 'https://podcasts.files.bbci.co.uk/p0605sx6.rss',
      album: 'Evil Genius',
      artist: 'BBC',
      recent: 2
    },
    {
      url: 'https://podcasts.files.bbci.co.uk/p004t1hd.rss',
      album: 'Witness History',
      artist: 'BBC',
      recent: 6
    },
    {
      url: 'http://answermethis.libsyn.com/rss',
      album: 'Answer Me This',
      artist: 'HO',
      recent: 2
    },
    {
      url: 'https://podcast.global.com/show/3237607/episodes/feed',
      album: 'The Week Unwrapped',
      artist: 'HO',
      recent: 2
    },
    {
      url: 'https://podcasts.files.bbci.co.uk/b006qykl.rss',
      album: 'In Our Time',
      artist: 'BBC',
      recent: 2
    },
    {
      url: 'https://feeds.theincomparable.com/randomtrek',
      album: 'Random Trek',
      artist: 'Incomparable',
      recent: 5
    },
    {
      url: 'https://feeds.theincomparable.com/voyager',
      album: 'Voyager Revisited',
      artist: 'Incomparable',
      recent: 30
    }
  ])