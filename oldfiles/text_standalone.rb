
require 'ruby-processing'

class Text
  def initialize
    
  end
end


class TextJunk < Processing::App
  def setup
    puts "--------------"
    fill(0)
    @buff_pos = 0
    @buff_offset = 0
    @buff = ""
    @text = ""
    
    #hint(ENABLE_NATIVE_FONTS)
    #font = create_font("Arial", 66)
    font = create_font("Univers45.vlw", 66)
    #font = loadFont("Univers45.vlw")
    text_font(font, 20)
    text("text", 3, 4, 200, 200)
  end
  
  def draw
    background(176)
    if((millis() % 500) < 250)  # Only fill cursor half the time
      noFill();
    else 
      fill(255);
      stroke(0);
    end
    rPos = textWidth(@buff[0...(@buff.length - @buff_offset)]) + 10
    rect(rPos+1, 19, 10, 21)
    
    text(@buff, 10, 19, 200, 201)
  end
  
  def key_pressed
    case key
    when 5000..800000
      #this is to catch shift and arrows
    when 8
      @buff.chop!
    when 10
      
    when 2     #these are for emacs-type movements
      @buff_offset += 1
    when 6
      @buff_offset -= 1
    else
      @buff << key
    end
    #key != 8 ? @buff << key : @buff.chop!
    puts key
  end
end
TextJunk.new :title => "TextJunk", :width => 350, :height => 350


=begin
/**
 * Typing (Excerpt from the piece Textension) 
 * by Josh Nimoy.  
 * 
 * Click in the window to give it focus.
 * Type to add letters and press backspace or delete to remove them. 
 */


int leftmargin = 10;
int rightmargin = 20;
String buff = "";
boolean didntTypeYet = true;

void setup()
{
  size(640, 360, P3D);
  textFont(loadFont("Univers45.vlw"), 25);
}

void draw()
{
  background(176);

  if((millis() % 500) < 250){  // Only fill cursor half the time
    noFill();
  }
  else {
    fill(255);
    stroke(0);
  }
  float rPos;
  // Store the cursor rectangle's position
  rPos = textWidth(buff) + leftmargin;
  rect(rPos+1, 19, 10, 21);

  // Some instructions at first
  if(didntTypeYet) {
    fill(0);
    //text("Use the keyboard.", 22, 40);
  }

  fill(0);
  pushMatrix();
  translate(rPos,10+25);
  char k;
  for(int i = 0;i < buff.length(); i++) {
    k = buff.charAt(i);
    translate(-textWidth(k),0);
    rotateY(-textWidth(k)/70.0); 
    rotateX(textWidth(k)/70.0);
    scale(1.1);
    text(k,0,0);
  }
  popMatrix();
}

void keyPressed()
{
  char k;
  k = (char)key;
  switch(k){
  case 8:
    if(buff.length()>0){
      buff = buff.substring(1);
    }
    break;
  case 13:  // Avoid special keys
  case 10:
  case 65535:
  case 127:
  case 27:
    break;
  default:
    if(textWidth(buff+k)+leftmargin < width-rightmargin){
      didntTypeYet = false;
      buff=k+buff;
    }
    break;
  }
}
=end