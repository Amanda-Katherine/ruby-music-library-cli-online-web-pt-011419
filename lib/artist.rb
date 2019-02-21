require 'pry'

class Artist

  extend Concerns::Findable

  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def genres
    genres = self.songs.collect do |song|
      song.genre
    end
    genres.uniq
  end

  def add_song(song)
    song.artist = self unless song.artist != nil
    @songs << song unless @songs.include?(song)
  end

  def songs
    @songs
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.name = name
    artist.save
    artist
  end


end
