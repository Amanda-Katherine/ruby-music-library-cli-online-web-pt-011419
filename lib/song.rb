require 'pry'

class Song

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) unless artist == nil
    self.genre=(genre) unless genre == nil
  end

  def genre=(genre)
    @genre = genre
    self.genre.songs << self unless genre.songs.include?(self)
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
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

  def self.create(name, artist = nil, genre = nil)
    song = Song.new(name, artist, genre)
    song.name = name
    song.save
    song
  end

  def self.find_by_name(name)
    self.all.find { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  def self.new_from_filename(filename)
    artist = Artist.find_or_create_by_name(filename.split(" - ")[0])
    genre = Genre.find_or_create_by_name(filename.split(" - ")[2].gsub(".mp3", ""))
    create(filename.split(" - ")[1], artist, genre)
  end

  def self.create_from_filename(filename)
    new_from_filename(filename)
  end

end
