require 'csv'
require 'time'

class Pet
  attr_accessor :name, :birthdate, :status, :hungry, :next_feed_at, :bored, :play_count, :sleepy
  def initialize(pet_data = {})
    @name = ""
    @birthdate = Time.now
    @status = "cranky"
    @hungry = true
    @next_feed_at = birthdate
    @bored = true
    @play_count = 0
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
  def self.feed(pet, pet_data)
    if Time.now > Time.parse(pet.next_feed_at.to_s)
      pet.hungry = false
      new_food = Food.new
      puts "You fed #{pet.name} a #{new_food.type}."
      puts "#{pet.name} is no longer hungry."
      pet.next_feed_at = (Time.now + 120).to_s
      pet.status = "happy"
      current_pet_data = CSV.read(pet_data)
      File.open(pet_data, "w"){ |csv| csv.print "#{pet.name},#{pet.birthdate},#{pet.status},#{pet.hungry},#{pet.next_feed_at},#{pet.bored},#{pet.play_count},#{pet.sleepy}" }
    else
      pet.status = "disturbed"
      puts "#{pet.name} is not hungry, and gets slightly disturbed!"
      File.open(pet_data, "w"){ |csv| csv.print "#{pet.name},#{pet.birthdate},#{pet.status},#{pet.hungry},#{pet.next_feed_at},#{pet.bored},#{pet.play_count},#{pet.sleepy}" }
    end
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

  def display_overall_status(pet)
    puts "#{pet.name} is #{pet.status}."
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
  attr_reader :view, :data_file, :csv_pet_data
  attr_accessor :pet

  include Caretaker

  def initialize(pet_data)
    @view = View.new
    @pet = Pet.new
    @data_file = pet_data
    @csv_pet_data = CSV.read(pet_data)
    if csv_pet_data[0].nil?
      view.display_name_request
      pet.name = view.get_input
      pet.birthdate = Time.now
      File.open(pet_data, "w"){ |csv| csv.print "#{pet.name},#{pet.birthdate},#{pet.status},#{pet.hungry},#{pet.next_feed_at},#{pet.bored},#{pet.play_count},#{pet.sleepy}" }
      view.display_birth(pet.name)
      view.display_food_status(pet)
      view.display_bored_status(pet)
      view.display_sleepy_status(pet)
      view.display_instructions

      run
    else
      pet.name = csv_pet_data[0][0]
      pet.birthdate = csv_pet_data[0][1]
      pet.status = csv_pet_data[0][2]
      pet.hungry = csv_pet_data[0][3]
      pet.next_feed_at = csv_pet_data[0][4]
      pet.bored = csv_pet_data[0][5]
      pet.play_count = csv_pet_data[0][6]
      pet.sleepy = csv_pet_data[0][7]
      view.display_food_status(pet)
      view.display_bored_status(pet)
      view.display_sleepy_status(pet)
      view.display_instructions

      run
    end
  end

  def run
    view.display_overall_status(pet)
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
        Caretaker.feed(pet, data_file)
      when 'sleep'
        Caretaker.put_to_bed(pet)
      else
        view.error(pet)
      end
    end
  end
end

Controller.new('pet_data.csv')
