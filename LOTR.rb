require 'colored'

## Model
class Hobbit

  def initialize
    @ring_on = false
  end

  def wear_or_remove_the_one_ring
    @ring_on = !@ring_on
  end

  def walk_to_mordor
    "I hate spiders"
  end

  def wearing_ring?
    @ring_on
  end

  def complain
    "Frodo bitches...."
  end

end

class TheOneRing
  def get_frodo_caught
    "The Wraiths are coming."
  end
end


## Controller

class Quest

  def initialize hobbit
    @hobbit = hobbit
  end

  def fly_you_fools!
    View.welcome
    View.menu
    collect
  end

  def user_input
    gets.chomp
  end

  def collect
    input = user_input

    if @hobbit.wearing_ring?
      return View.console "Frodo has been caught by Wraiths"
    end

    case input
    when "1"
      View.console @hobbit.walk_to_mordor
    when "2"
      @hobbit.wear_or_remove_the_one_ring
    when "3"
      View.console @hobbit.complain
    when "4"
      View.console "Don't tell the dwarf"
    end

    fly_you_fools! unless input == "4"

  end

end


## View
class View

  class << self

    def welcome
      puts "*"*25
      puts "Lord of the Rings"
      puts "*"*25
    end

    def menu
      puts "Make a selection"
      puts "1. Walk to Mordor"
      puts "2. Wear/Remove the Ring"
      puts "3. Complain about the burden of the Ring even though it's something Frodo decided to do for himself"
    end

    def console string
      puts '-'*25
      puts "\n" + string.red + "\n"
      puts '-'*25
    end

  end


end

frodo = Hobbit.new
lotr = Quest.new(frodo)
lotr.fly_you_fools!
