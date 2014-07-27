class Pet
  attr_accessor :name, :hungry, :bored, :sleepy
  def initialize
    @name = ""
    @hungry = true
    @bored = true
    @sleepy = true
  end
end

class Food
  attr_reader :type

  COLORS = ["blue", "green", "yellow", "red", "purple", "pink", "rainbow"]
  TYPE = ["pizza", "burger", "fries", "ribs", "cheesecake", "ice-cream", "broccoli"]

  def initialize
    @type = "#{COLORS.sample} #{TYPE.sample}"
  end
end

module Caretaker
  def self.feed(pet)
    pet.hungry = false
    new_food = Food.new
    puts "You fed #{pet.name} a #{new_food.type}."
    puts "#{pet.name} is no longer hungry."
  end

  def self.play(pet)
    pet.bored = false
    puts "#{pet.name} is no longer bored."
  end

  def self.put_to_bed(pet)
    pet.sleepy = false
    puts "#{pet.name} is no longer sleepy."
  end
end

class View
  def initialize
    display_welcome
  end

  def get_input
    gets.chomp
  end

  def display_welcome
    puts "Welcome to RUBY Pets"
  end

  def display_instructions
    puts "Change the status of your pet, enter the commands below:"
    puts "FEED".center(10) + "PLAY".center(10) + "SLEEP".center(10)
  end

  def display_name_request
    puts "What would you like to call your pet?"
  end

  def display_birth(name)
    puts "Congratulations! You are the proud parent of #{name}."
  end

  def display_food_status(pet)
    if pet.hungry == true
      puts "#{pet.name} is still hungry."
    else
      puts "#{pet.name} is not hungry."
    end
  end

  def display_bored_status(pet)
    if pet.bored == true
      puts "#{pet.name} is still bored."
    else
      puts "#{pet.name} is not bored."
    end
  end

  def display_sleepy_status(pet)
    if pet.sleepy == true
      puts "#{pet.name} is still sleepy."
    else
      puts "#{pet.name} is not sleepy."
    end
  end

  def error(pet)
    puts "Unable to interact with #{pet.name} in that way. FREAK!"
  end
end

class Controller
  attr_reader :view
  attr_accessor :pet

  include Caretaker

  def initialize
    @view = View.new
    @pet = Pet.new
    view.display_name_request
    pet.name = view.get_input
    view.display_birth(pet.name)
    view.display_food_status(pet)
    view.display_bored_status(pet)
    view.display_sleepy_status(pet)
    view.display_instructions

    run
  end

  def run
    input = ""
    until input == 'exit'
      input = view.get_input.downcase
      case input
      when 'exit'
        break
      when 'help'
        view.display_instructions
      when 'play'
        Caretaker.play(pet)
      when 'feed'
        Caretaker.feed(pet)
      when 'sleep'
        Caretaker.put_to_bed(pet)
      else
        view.error(pet)
      end
    end
  end
end

Controller.new
