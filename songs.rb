class Song
  
  
  attr_accessor :song_id, :title, :artist, :genre_id, :status_id, :desire_level
    
  def initialize(song_id = nil ,title = nil, artist = nil, genre_id = nil, status_id = nil, desire_level = 0)
    @song_id = song_id
    @title = title
    @artist = artist
    @genre_id = genre_id
    @status_id = status_id
    @desire_level = desire_level
  end
  
  def self.find(song_id)
   
    result = CONNECTION.execute("SELECT * FROM songs WHERE id = #{song_id};").first
    
    temp_title = result["title"]
    temp_artist = result["artist"]
    temp_genre_id = result["genre_id"]
    temp_status_id = result["status_id"]
    temp_desire_level = result["desire_level"]
    
    Song.new(song_id, temp_title, temp_artist, temp_genre_id, temp_status_id, temp_desire_level)
  end
  
  #goes into the songs table and returns all records
  #
  #all - requires no input pulls all records form songs table
  #
  #returns - Array objects of songs 
  def self.all
    results = CONNECTION.execute('SELECT * FROM songs;')
    
    results_as_objects = []
    
    results.each do |result_hash|
      results_as_objects << Song.new(result_hash["id"], result_hash["title"], result_hash["artist"], result_hash["genre_id"], result_hash["status_id"], result_hash["desire_level"])
    end
  
    return results_as_objects
  end

  #adds a new song record
  #
  #add - String, String, Intiger, Intiger
  #
  #returns- empty Array
  def self.add(title, artist, genre_id, status_id)
    if self.exist?(title, artist) == false
    CONNECTION.execute("INSERT INTO songs (title, artist, genre_id, status_id) VALUES ('#{title}', '#{artist}', #{genre_id}, #{status_id});")
    
    song_id = CONNECTION.last_insert_row_id
    
    Song.new(song_id, title, artist, genre_id, status_id)
  else
    false
  end
  end
  
  #saves the changes ruby made to the row
  #
  #returns unknown
  def save
    query_string = "UPDATE songs SET title = '#{title}', artist = '#{artist}', genre_id = #{genre_id}, status_id = #{status_id}, desire_level = #{desire_level} WHERE id = #{song_id};"
    CONNECTION.execute(query_string)
  end
  
#  --------------------- Updating existing records -----------------------------------
  #change title of song record
  #
  #change_title - needs new title String form
  #
  #returns - UNKNOWN
  def change_title(new_song_title)
    @title = new_song_title
  end
  
  #changes artist of a song record
  #
  #change_artist - needs new artist name String form
  #
  #returns - UNKNOWN
  def change_artist(new_song_artist)
   @artist = new_song_artist
  end
  
  #change stage of status of song record
  #
  #nchange_status_stage - needs ID of status stage Intiger form
  #
  #UNKNOWN
  def change_status_stage(new_status_stage_id)
    @status = new_status_stage_id
  end
  
  #change type of genre of a song record
  #
  #change_genre_type - needs ID of genre type Intiger form
  #
  #returns - Array of hashes
  def change_genre_type(new_genre_type_id)
    @genre = new_genre_type_id
  end
  
# ------------------------viewing existing records-------------------------------
  #what it does
  #
  #genre_type - needs id of genre type in Intiger form
  #
  #returns - empty Array if nothing in that genre type Array of hashes if content
  def self.genre_type (genre_id)
    query_string = "SELECT * FROM songs WHERE genre_id = #{genre_id}"
       CONNECTION.execute(query_string)       
  end
  
  #complies a list of all songs with the same status
  #
  #status_stage - needs id of status stage Intiger form
  #
  #returns - empty Array if nothing in that genre type Array of hashes if content
  def self.status_stage (status_id)
    query_string = "SELECT * FROM songs WHERE status_id = #{status_id}"
       CONNECTION.execute(query_string)       
  end
  
  #Compliles list of songs with the same artist
  #
  #where_artist - artist name needed in String form
  #
  #returns - empty Array if no song records with that artist Array of hashes if content
  def self.artist (artist_name)
    query_string ="SELECT * FROM songs WHERE artist = '#{artist_name}'"
       CONNECTION.execute(query_string)       
  end
  
# -----------------------------deleting existing records -------------------------

  #deletes complete song record
  #
  #delete_song_record - id of the song to be delted Intiger
  #
  #returns - empty Array
  def delete_song_record(delete_selected)
    CONNECTION.execute("DELETE FROM songs WHERE id = '#{delete_selected}';")
  end
  #  --------------------- desire level logic -----------------------------------
  
  #if song and artist pair exist in database increase desire level +1
  #
  #arow_from_table - text and text
  #
  #returns an array containing the row as object
  def self.get_row(title, artist)
        result = CONNECTION.execute("SELECT * FROM songs WHERE artist = '#{artist}' AND title = '#{title}'") 
       
        results_as_objects = []
    
        result.each do |result_hash|
        results_as_objects << Song.new(result_hash["id"], result_hash["title"], result_hash["artist"], result_hash["genre_id"], result_hash["status_id"], result_hash["desire_level"])
        end
        return results_as_objects
  end
  
  def self.get_level(title, artist)
        
        result = CONNECTION.execute("SELECT * FROM songs WHERE artist = '#{artist}' AND title = '#{title}'").first 
        result["desire_level"]
        
  end
  
  def self.exist?(title, artist)
        get_row(title, artist).length > 0
  end
  
end