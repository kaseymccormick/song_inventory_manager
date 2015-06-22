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

##_________________________Adding info___________________

# add/type stage song
get "/add/song" do
  erb :"add_song_form"
end

get "/save_song" do

    # `params` example: {"student_id" => "4", "question_text" => "Help?!"}
  
    new_song = Song.new(nil, params["title"], params["artist"], params["type"], params["stage"])

    if Song.add(params["title"], params["artist"], params["type"], params["stage"])
      "Song added"
      erb :"complete_song_list"
    else
      updated_level = (Song.get_level(params["title"], params["artist"]) +1)
      song = Song.get_row(params["title"], params["artist"]).first
      
      
      song.desire_level = updated_level
      song.save
      "desire level adjusted"
      @desire_level =true
      erb :"complete_song_list"
    end
  end


# add type
get "/add/type" do
  erb :"add_type_form"
end

get "/add_type" do
  Genre.add(params["type"])
  "type added"
end

get "/add_stage" do
  Status.add(params["stage"])
  "stage added"
end

# add stage
get "/add/stage" do
  erb :"add_stage_form"
end
##____________________________________________________________________
##_____________________________________start of view x
# view song list
get "/view/song_list" do
  erb :"complete_song_list"
end
#-----------------------------
#view all same artist
get "/view_same/artist" do
  erb :"filter_artist_form"
end

get "/save_artist_filter" do
  @these_songs = Song.artist(params["artist"])
  erb :"list_same"
end

#----------------------------- 

get "/view_same/type" do
  erb :"filter_type_form"
end

get "/save_type_filter" do
  @these_songs = Song.genre_type(params["type"])
  erb :"list_same"
end

#----------------------------

get "/view_same/stage" do
  erb :"filter_stage_form"
end

get "/save_stage_filter" do
  @these_songs = Song.status_stage(params["stage"])
  erb :"list_same"
end

#------------------
###_________________________________________________________________


#edit/ title artist genre status
get "/edit/title" do
  erb :"edit_title_form"
end

get "/edit/save_new_title" do
  song = Song.find(params["id"])
  song.title = (params["new_title"])
  song.save
  erb :"complete_song_list"
  @song_edit = true
end


get "/edit/artist" do
  erb :"edit_artist_form"
end

get "/edit/save_new_artist" do
  song = Song.find(params["id"])
  song.artist = (params["new_artist"])
  song.save
  
  @song_edit = true  
  erb :"complete_song_list"
  
end

get "/edit/genre" do
  erb :"edit_genre_form"
end

get "/edit/save_new_genre" do
  song = Song.find(params["id"])
  song.genre_id = (params["type"])
  song.save
  
  @song_edit = true
  erb :"complete_song_list"
end

get "/edit/status" do
  erb :"edit_status_form"
end

get "/edit/save_new_status" do
  song = Song.find(params["id"])
  song.status_id = (params["stage"])
  song.save
  
  @song_edit = true
  erb :"complete_song_list"
end

get "/edit/complete_record" do
  erb :"edit_song_record_form"
end

get "/edit/save_updated_song_record" do
  song = Song.find(params["id"])
  
  song.title = (params["new_title"])
  song.artist = (params["new_artist"])
  song.genre_id = (params["type"])
  song.status_id = (params["stage"])
  
  
  song.save
  
  
  
  @song_edit = true
  erb :"complete_song_list"
end
##________________________________DELETE__________________

get "/delete/song" do
  erb :"delete_song_form"
end

get "/delete/song_save" do
  song = Song.new(params["id"])
  song.delete_song_record(params["id"])
  @song_delete = true
  erb :"complete_song_list"
end

get "/delete/type" do
  erb :"delete_type_form"
end


get "/delete/type_save" do
  Genre.delete_type(params["id"])
  "genre type deleted"
end

get"/delete/stage" do
    erb :"delete_stage_form"
end

get "/delete/stage_save" do
  binding.pry
  Status.delete_stage(params["id"])
  "Status stage deleted"

end


##________________________________________________________

