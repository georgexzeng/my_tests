# to_s method

# any class you define should have a to_s instance method to return a string representation
# of the object.  following is a simple example to represent a Box object in terms of
# width and height:

# class Box
#   def initialize(w, h)
#     @width, @height = w, h
#   end

#   def to_s
#     "(w:#@width, h:#@height)"
#   end

# end

# box = Box.new(10, 20)
# puts "String representation of box is : #{box}"


# Access Control - three levels of protection:

# public - called by anyone.  methods default by public except for initialize
# which is always private

# private methods - private methods cannot be cacessed or viewed from outside
# class.  only class methods can access private members

# protected method - can be invoked only by ojects of the defining class and
# its subclasses.  access is kept within family

# class Box
#   def initialize(w, h)
#     @width, @height = w, h
#   end

#   def getArea
#     getWidth() * getHeight
#   end

#   def getWidth
#     @width
#   end

#   def getHeight
#     @height
#   end

#   private :getWidth, :getHeight

#   def printArea
#     @area = getWidth() * getHeight
#     puts 'Big box area is :area'
#   end

#   protected :printArea

# end

# box = Box.new(10, 20)

# a = box.getArea()
# puts "Area of the box is #{a}"

# box.printArea()

class Box
  def initialize(w, h)
    @width, @height = w, h
  end

  def getArea
    @width * @height
  end

end

class BigBox < Box

  def printArea
    @area = @width * @height
    puts "Big box area is: #@area"
  end
end

box = BigBox.new(10, 20)

box.printArea()
