class Genre
  attr_reader :id
  attr_accessor :type
  
  def initialize(id = nil, type = nil)
    @id = id
    @type = type
  end
  
  #complies all rows from Genre table
  #
  #returns - Array of Hashes of the table
  def self.all
    results = CONNECTION.execute('SELECT * FROM genres;')
    
    results_as_objects = []
    
    results.each do |result_hash|
      results_as_objects << Genre.new(result_hash["id"], result_hash["type"])
    end
    
    return results_as_objects
  end
  
  #adds a row to the genre table
  #
  #input - string (genre_type)
  #
  #returns - empty Array
  def self.add(genre_type)
    query_string = "INSERT INTO genres (type) VALUES ('#{genre_type}');"
    CONNECTION.execute(query_string)
  end
    
  #deletes existing genre
  def self.delete_type(delete_selected)
    CONNECTION.execute("DELETE FROM genres WHERE id = #{delete_selected};")
  end

end