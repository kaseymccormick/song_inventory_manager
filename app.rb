require "pry"
require "sinatra"
require "sinatra/reloader"
require "SQLite3"

#Load/create our database for this program.
CONNECTION = SQLite3::Database.new("song_inventory_management.db")

 #Make the tables.
CONNECTION.execute("CREATE TABLE IF NOT EXISTS songs (id INTEGER PRIMARY KEY, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP, title TEXT, artist TEXT, genre_id INTEGER, status_id INTEGER, desire_level INTEGER DEFAULT 0, FOREIGN KEY(genre_id) REFERENCES genres(id),  FOREIGN KEY(status_id) REFERENCES statuses(id));")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS statuses (id INTEGER PRIMARY KEY, stage TEXT);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS genres (id INTEGER PRIMARY KEY, type TEXT);")

#Get results as an Array of Hashes.
CONNECTION.results_as_hash = true

#copy pasting genres, statuses and songs content to app.rb for access
require_relative "genres.rb"
require_relative "statuses.rb"
require_relative "songs.rb"

#------------- Web interface -------------------------
get "/home" do
  erb :"homepage"
end

# add/type stage song
get "/add/song" do
  erb :"add_song_form"
end

get "/save_song" do

    # `params` example: {"student_id" => "4", "question_text" => "Help?!"}
  
    new_song = Song.new(nil, params["title"], params["artist"], params["type"], params["stage"])

    if Song.add(params["title"], params["artist"], params["type"], params["stage"])
      "Song added"
    else
      updated_level = (Song.get_level(params["title"], params["artist"]) +1)
      song = Song.get_row(params["title"], params["artist"]).first
      
      
      song.desire_level = updated_level
      song.save
      "desire level adjusted"
    end
  end
 #  @new_song = Song.new
#
#   if new_song.exist?(params["title"], params["artist"]) == false
#     Song.add(song_title, song_artist, genre_id, status_id)
#     erb :"song_added"
#   else
#     "Failure. Try again."
#   end
# end
#
# if Song.exist?(song_title, song_artist) == false
#   #going into song class using add method passing arguments of title, artist, genre_id, status_id to create a new object of song.       Creating a row in the Songs table
#     Song.add(song_title, song_artist, genre_id, status_id)
# else
#    updated_level = (Song.get_level(song_title, song_artist) +1)
#
#
#    song = Song.get_row(song_title, song_artist).first
#
#
#    song.desire_level = updated_level
#    song.save
#
#
#   puts "song, already added, increasing desire level to #{updated_level}."
# end


# add/type stage song
get "/add/type" do
  erb :"add_type_form"
end

get "/add/stage" do
  erb :"add_stage_form"
end

get "/view/song_list" do
  erb :"complete_song_list"
end

get "/view_same/artist" do
  erb :"filter_artist_form"
end

get "/view_same/type" do
  erb :"filter_type_form"
end

get "/view_same/stage" do
  erb :"filter_stage_form"
end

get "/save_genre_type_filter" do
  erb :"type_filter_list"
end

get "/save_status_stage_filter" do
  erb :"stage_filter_list"
end

get "/save_artist_filter" do
  erb :"artist_filter_list"
end

#edit/ title artist genre status
get "/edit/title" do
  erb :"edit_title_form"
end

# # when get the save do bleh
# get
# end


get "/edit/artist" do
  erb :"edit_artist_form"
end

# when get the save do bleh
# get
# end

get "/edit/genre" do
  erb :"edit_genre_form"
end

# when get the save do bleh
# get
# end

get "/edit/status" do
  erb :"edit_status_form"
end

# # when get the save do bleh
# get do
# end


