class MusicImporter

  attr_accessor :path
  attr_reader :song

  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(path).select {|entry| entry.include?(".mp3")}
  end

  def import
    files.each {|file| Song.create_from_filename(file)}
  end

end
