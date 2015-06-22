class Status
  attr_reader :id
  attr_accessor :stage
  
  def initialize(id = nil, stage = nil)
    @id = id
    @stage = stage
  end
  
  #gets everything from statuses table
  #
  #returns - Array of hashes
  def self.all
    results = CONNECTION.execute('SELECT * FROM statuses;')
    
    results_as_objects = []
    
    results.each do |result_hash|
      results_as_objects << Status.new(result_hash["id"], result_hash["stage"])
    end
    
    return results_as_objects    
  end

  #adds status stage to statuses table 
  #
  #returns - empty Array
  def self.add(status_stage)
    query_string = "INSERT INTO statuses (stage) VALUES ('#{status_stage}');"
    CONNECTION.execute(query_string)
  end
  
  #deletes existing stage
  def self.delete_stage(delete_selected)
    binding.pry
    CONNECTION.execute("DELETE FROM statuses WHERE id = #{delete_selected};")
    # CONNECTION.execute("DELETE FROM statuses WHERE id = 5;")
  end

end