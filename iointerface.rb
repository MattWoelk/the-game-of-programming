class IoInterface
  attr_accessor :data
  def initialize send_to
    @data = [] #array of strings
    @data_read = []
    @send_to = send_to
    @new = false
    
    #@last_modified = 0 #doesn't work. only down to the second..
  end
  
  def error
    output! "invalid - nothing happened."
  end
  
  def clearfiles
    file = File.open("to_script.txt", "w")
    file.print ""
    file.close
    
    file = File.open("to_game.txt", "w")
    file.print ""
    file.close
  end
  
  def output! text
    file = File.open("to_script.txt", "a")
    file.print text if !text.nil?
    file.close #then do this only once at the end of something??
  end
  
  def read_data
    if @new
      @new = false
      return @data[-1]
    end
  end

  def input!
    #@last_modified = File.mtime("to_game.txt") #doesn't work => see top.
    @data_read = []
    file = File.open("to_game.txt", "r")
    while content = file.gets
      @data_read << content
    end
    file.close
    if @data.length < @data_read.length
      @data = @data_read
      @new = true
      puts @data[-1]
    end
    if @data.nil?
      @new = true
    end
  end
end