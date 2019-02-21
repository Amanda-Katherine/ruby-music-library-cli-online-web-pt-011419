require 'pry'

class MusicLibraryController

  attr_accessor :path

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    puts "Welcome to your music library!"
    input = ""
    until input == "exit"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.strip
    end
  end

  def list_songs
    Song.all.sort_by! { |song| song.name}
    Song.all.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end


  def list_artists
    Artist.all.sort_by! { |artist| artist.name}
    Artist.all.each_with_index { |artist, index| puts "#{index + 1}. #{artist.name}"}
  end

  def list_genres
    Genre.all.sort_by! { |genre| genre.name}
    Genre.all.each_with_index { |genre, index| puts "#{index + 1}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp

    if artist = Artist.find_by_name(input)
      artist.songs.sort_by! { |song| song.name}.each_with_index do |song, index|
        puts "#{index + 1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp

    if genre = Genre.find_by_name(input)
      genre.songs.sort_by! { |song| song.genre}.each_with_index do |song, index|
        puts "#{index + 1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i

    Song.all.sort_by! { |song| song.name}
    Song.all.each_with_index do |song, index|
      if index == input
        puts song
      else
        puts "Can't Play That One."
      end
    end
  end

  # def play_song
  #   list_songs
  #   puts "Which song number would you like to play?"
  #   input = gets.strip.to_i - 1
  #
  #   songs = Song.all.sort_by! { |song| song.name}
  #   # .each_with_index { |song, index| end
  #   # song = Song.all[input]
  #   binding.pry
  #   # puts "Playing #{song.name} by #{song.artist.name}"
  # end

    #if input.between?(0, Song.all.length - 1)
end
