# chainring = 52
# cog = 11
# ratio = chainring/cog.to_f
# puts ratio

# chainring = 30
# cog = 27
# ratio = chainring / cog.to_f
# puts ratio

# class Gear

#   attr_reader :chainring, :cog, :rim, :tire

#   def initialize(chainring, cog, rim, tire)
#     @chainring = chainring
#     @cog = cog
#     @rim = rim
#     @tire = tire
#   end

#   def ratio
#     chainring / cog.to_f
#   end

#   def gear_inches
#     ratio * (rim + (tire * 2))
#   end

# end

# puts Gear.new(52, 11, 26, 1.5).gear_inches

# puts Gear.new(52, 11, 24, 1.25).gear_inches

# class OscuringReferences
#   attr_reader :data
#   def initialize(data)
#     @data = data
#   end

#   def diameters
#     data.collect {|cell| cell [0] + (cell[1] * 2)}
#   end

# end

# @data = [[622, 20], [622, 23], [559, 30], [559, 40]]

# class RevealingReferences
#   attr_reader :wheels
#   def initialize(data)
#     @wheels = wheelify(data)
#   end

#   def diameters
#     wheels.collect {|wheel| wheel.rim + (wheel.tire * 2)}
#   end

#   Wheel = Struct.new(:rim, :tire)
#   def wheelify(data)
#     data.collect {|cell| Wheel.new(cell[0], cell[1])}
#   end
# end

# class Gear
#   attr_reader :chainring, :cog, :wheel
#   def initialize(chainring, cog, wheel=nil)
#     @chainring = chainring
#     @cog = cog
#     @wheel = wheel
#   end

#   def ratio
#     chainring / cog.to_f
#   end

#   def gear_inches
#     ratio * wheel.diameter
#   end
# end

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    rim + (tire * 2)
  end

  def circumference
    diameter * Math::PI
  end
end

# @wheel = Wheel.new(26, 1.5)
# puts @wheel.circumference

# puts Gear.new(52, 11, @wheel).gear_inches

# puts Gear.new(52, 11).ratio

class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(args)
    @chainring = args[:chainring]
    @cog = args[:cogs]
    @wheel = args[:wheel]
  end

  def gear_inches
    ratio * wheel.diameter
  end

  def ratio
    chainring / cog.to_f
  end

end

puts Gear.new(
  :chainring => 52,
  :cog => 11,
  :wheel => Wheel.new(26, 1.5)).gear_inches




