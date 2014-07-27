class Gumball
  FLAVOURS = ["strawberry", "banana", "cherry", "grape", "lemon", "cotton candy", "raspberry"]
  COLOURS = ["red", "yellow", "purple", "pink", "blue"]

  attr_reader :flavour, :colour

  def initialize(args = {})
    @flavour = args[:flavour] || FLAVOURS.sample
    @colour = args[:colour] || COLOURS.sample
  end
end

module GumballLoader
    def self.create_gumballs(num)
      Array.new(num) { Gumball.new }
    end
end

class GumballMachine
  attr_reader :quarters_in_lock_box, :contents

  def initialize
    @contents = []
    @quarters_in_lock_box = 0
  end

  def insert_quarter
    self.quarters_in_lock_box += 1
    release_gumball
  end

  def release_gumball
    contents.shift
  end

  def add_gumballs(gumballs)
    self.contents = (contents + gumballs).shuffle
  end

  protected
  attr_writer :quarters_in_lock_box, :contents
end

class Controller
  def initialize
    @view = View.new
    @machine = GumballMachine.new
    supply = GumballLoader.create_gumballs(3)
    @machine.add_gumballs(supply)

    run
  end

  def run
    input = ""
    until input == "exit"
      @view.display_prompt
      input = @view.get_input
      case input
      when "exit"
        break
      when "help"
        @view.display_options
      when "insert quarter"
        insert_quarter
      end
    end
  end

  def insert_quarter
    gumball = @machine.insert_quarter
    if gumball
      @view.deliver(gumball)
    else
      @view.display_apology
    end
  end
end

class View
  def initialize
    display_welcome
  end

  def get_input
    gets.chomp
  end

  def display_options
    puts "Options: 'exit' or 'insert quarter'"
  end

  def display_prompt
    puts "Please insert a quarter! (type 'insert quarter')"
  end

  def display_welcome
    puts "welcome to the gumball machine!"
  end

  def deliver(gumball)
    puts "Yum! You got a #{gumball.colour} #{gumball.flavour}!"
  end

  def display_apology
    puts "Thanks for the quarter, but sorry, we're out of gumballs!"
  end
end

Controller.new
