#current problem:
# not enough rocks sometimes! it's pretty random! (when fixing, watch for inf loop!)
# rock in (0,0)  !!!! 

class Lawn
  attr_accessor :lawn, :dudex, :dudey, :victory, :collision, :output_some_text
  def initialize size, offset
    @lawn = [] #'W ','O ',or 'w '
    @collision = true
    @output_some_text = false
    @size = size
    @offset = offset
    @dudex = 0
    @dudey = 0
    @victory = false
    @vic_button = [@offset + 30, @offset + 30, 35] #x,y,r
    @fill = [50, 50, 10]
    @checked_places = [] #false if it's been checked over
    #$app.ellipse_mode CORNER
  end
  
  def filllawn(x,y)
    x.times do |a|
      @lawn[a] = []
      y.times do |b|
        @lawn[a] << 'W'
      end
    end
    deploy_rock_herd 45 ####MAKE SURE IT IS NOT AN INFINITE LOOP
  end
  
  def deploy_rock_herd num
    num_left = num
    can_be_rock = true
    while num_left > 0
      x = (rand*@lawn.length).floor
      y = (rand*@lawn[0].length).floor
      if !rock?(x,y) && !(x == 0 && y == 0)
        @lawn[x][y] = 'O'
        up = false; right = false; down = false; left = false;
        
        set_recur(x,y-1) if in?(x,y-1)
        up = !in?(x,y-1) || rock?(x,y-1) || (in?(x,y-1) && recur_check(x,y-1,""))
        set_recur(x-1,y) if in?(x-1,y)
        left = !in?(x-1,y) || rock?(x-1,y) || (in?(x-1,y) && recur_check(x-1,y,""))
        set_recur(x+1,y) if in?(x+1,y)
        right = !in?(x+1,y) || rock?(x+1,y) || (in?(x+1,y) && recur_check(x+1,y,""))
        set_recur(x,y+1) if in?(x,y+1)
        down = !in?(x,y+1) || rock?(x,y+1) || (in?(x,y+1) && recur_check(x,y+1,""))
        
        can_be_rock = up && right && down && left
        
        if can_be_rock
          num_left -= 1
        else
          @lawn[x][y] = 'W'
        end
      end #if not rock
    end
  end
  
  def in? x, y
    return false if x < 0 || y < 0 || x >= @lawn.length || y >= @lawn[0].length
    true
  end
  
  def rock? x, y
    (@lawn[x][y] <=> 'O') == 0 ? true : false
  end
  
  def set_recur x, y
    @checked_places = []
    @lawn.length.times {|i| @checked_places << []}
    @checked_places.each {|a| @lawn[0].length.times{|b| a << true}}
    #we have just made a 2-dim array of falses
    @checked_places[x][y] = false
  end
  
  def recur_check x, y, spaces
    return true if x == 0 && y == 0 #base case
    @checked_places[x][y] = false
    up = false; right = false; down = false; left = false;
    
    up = recur_check(x,y-1,spaces + " ") if in?(x,y-1) && !rock?(x,y-1) && @checked_places[x][y-1]
    left = recur_check(x-1,y,spaces + " ") if in?(x-1,y) && !rock?(x-1,y) && @checked_places[x-1][y]
    right = recur_check(x+1,y,spaces + " ") if in?(x+1,y) && !rock?(x+1,y) && @checked_places[x+1][y]
    down = recur_check(x,y+1,spaces + " ") if in?(x,y+1) && !rock?(x,y+1) && @checked_places[x][y+1]
    
    return true if up || right || down || left
    false
  end
  
  def textlawn
    ps = ""
    @lawn[0].length.times do |x|
      ps << "row #{x}: "
      @lawn.length.times do |y|
        ps << @lawn[y][x] + " "
      end
      puts ps + ""
      ps = ""
    end
    puts "--lawn was just printed--"
  end
  
  def text
    total = ""
     ps = ""
     @lawn[0].length.times do |x|
       #ps << "row #{x}: "
       @lawn.length.times do |y|
         ps << @lawn[y][x]
       end
       total << ps + "\n"
       ps = ""
     end
     total
  end
  
  def printlawn
    #ps = ""
    if @victory
      $app.fill(@fill[0],@fill[1],@fill[2])
      $app.stroke 204, 102, 0
      $app.ellipse(@vic_button[0], @vic_button[1], @vic_button[2]*2, @vic_button[2]*2)
    else
      @lawn.length.times do |x|
        #ps << "row #{x}: "
        @lawn[0].length.times do |y|
          #ps << @lawn[x][y]
          drawelement x, y, @lawn[x][y]
        end
        #puts ps + ""
        #ps = ""
      end
      #puts "--lawn was just printed--"
      drawdude(@dudex*@size + @offset,@dudey*@size + @offset,@size,@size)
    end
  end
  
  def drawelement x, y, input
    drawgrass(x*@size + @offset,y*@size + @offset,@size,@size) if (input <=> 'W') == 0
    drawrock(x*@size + @offset,y*@size + @offset,@size,@size) if (input <=> 'O') == 0
    drawcut(x*@size + @offset,y*@size + @offset,@size,@size) if (input <=> 'w') == 0
  end
  
  def grassorrock
    rndchoice ? 'W' : 'O'
  end
  
  def rndchoice
    x = (rand*5).round
    return true if x>=1
    return false if x==0
  end
  
  def cut
    @lawn[@dudex][@dudey] = 'w' if (@lawn[@dudex][@dudey] <=> 'W') == 0
  end
  
  def key_pressed key
    case key
    when 5000..800000
      #this is to catch shift and arrows
    when 119
      duden
    when 115
      dudes
    when 97
      dudew
    when 100
      dudee
    when 101
      @victory = true
    else
    end
    #puts key
  end
  
  def duden
    if @dudey > 0 && (@collision && !rock?(@dudex,@dudey-1))
      @dudey -= 1 
      @output_some_text = true
    end
    cut
    success?
  end
  
  def dudes
    if @dudey < @lawn[0].length - 1 && (@collision && !rock?(@dudex,@dudey+1))
      @dudey += 1 
      @output_some_text = true
    end
    cut
    success?
  end
  
  def dudee
    if @dudex < @lawn.length - 1 && (@collision && !rock?(@dudex+1,@dudey))
      @dudex += 1 
      @output_some_text = true
    end
    cut
    success?
  end
  
  def dudew
    if @dudex > 0 && (@collision && !rock?(@dudex-1,@dudey))
      @dudex -= 1 
      @output_some_text = true
    end
    cut
    success?
  end
  
  def drawgrass(x,y,w,h)
    $app.line(x,y,x+(w/4),y+h)
    $app.line(x+(w/4),y+h,x+(w/2),y)
    $app.line(x+(w/2),y,x+(w/2)+(w/4),y+h)
    $app.line(x+(w/2)+(w/4),y+h,x+w,y)
  end
  
  def drawcut(x,y,w,h)
    drawgrass x+w/4,y+h/2,w-w/2,h/2
  end
  
  def drawdude(x,y,w,h)
    $app.no_fill
    $app.stroke 204, 102, 0
    $app.rect(x, y, w, h)
  end
  
  def drawrock(x,y,w,h)
    $app.ellipse(x,y,w,h)
  end
  
  def success?
    @lawn.each do |x|
      x.each do |y|
        return false if (y <=> 'W') == 0
      end
    end
    puts "success"
    @victory = true
    return true
  end
  
  def text_input inputted
    #deal with the text that is recieved from the iointerface!~!
    dudes if !inputted.nil? && (inputted <=> "s") == 0
    duden if !inputted.nil? && (inputted <=> "n") == 0
    dudee if !inputted.nil? && (inputted <=> "e") == 0
    dudew if !inputted.nil? && (inputted <=> "w") == 0
  end
  
  def text_output
    if @output_some_text
      @output_some_text = false
      "\nack"
    else
      nil
    end
  end
  
  def mouse_pressed x, y
    if @victory && $app.dist(x,y,@vic_button[0] + @vic_button[2],@vic_button[0] + @vic_button[2]) < @vic_button[2]
      @fill = [204, 110, 10]
      #puts "#{x}#{y}"
    end
  end
  
  def mouse_released x, y
    if @victory && $app.dist(x,y,@vic_button[0] + @vic_button[2],@vic_button[0] + @vic_button[2]) < @vic_button[2]
      #reset everything!!
      reset
    end
    @fill = [50,50,10]
  end
  
  def reset
    x = @lawn.length
    y = @lawn[0].length
    @lawn = []
    @dudex = 0
    @dudey = 0
    @victory = false
    filllawn x, y
    textlawn
    cut
  end
end





