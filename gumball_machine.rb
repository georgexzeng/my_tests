require 'pry'

class Gumball
  FLAVORS = ["strawberry", "chocolate", "banana", "lemon", "lime", "cotton candy"]
  COLORS = ["red", "blue", "green", "yellow", "black", "orange"]

  attr_reader :flavor, :color

  def initialize(args = {})
    @flavor = args[:flavor] || FLAVORS.sample
    @color = args[:color] || COLORS.sample
  end

end

module Gumball_loader

  def self.create_gumballs(num)
    Array.new(num) {Gumball.new}
  end

end

class Gumball_machine
  attr_reader :quarters_in_lockbox, :contents

  def initialize
    @contents = []
    @quarters_in_lockbox = 0
  end

  def insert_quarter
    self.quarters_in_lockbox += 1
    release_gumball
  end

  def release_gumball
    contents.shift
  end

  def add_gumballs(gumballs)
    self.contents = (contents + gumballs).shuffle
  end

  protected
  attr_writer :quarters_in_lockbox, :contents
end

class Controller

  def initialize
    @view = View.new
    @machine = Gumball_machine.new
    supply = Gumball_loader.create_gumballs(3)
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
    puts "Type in 'exit' or 'insert quarter'!"
  end

  def display_prompt
    puts "Insert a quarter! (Type 'insert quarter')"
  end

  def display_welcome
    puts "Welcome to the gumball machine!"
  end

  def deliver(gumball)
    puts "Awesome!  You got a #{gumball.color} #{gumball.flavor} gumball!"

  end

  def display_apology
    puts "Sorry - but we're out of gumballs!"
  end

end

Controller.new
