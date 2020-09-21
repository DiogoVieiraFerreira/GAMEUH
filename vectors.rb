
class Vector2
    attr_accessor :x, :y
    def initialize x= 0, y= 0
        @x, @y = x, y
    end
    def * value
        @x *= value
        @y *= value
    end
end
class Vector3
    attr_accessor :x, :y, :z
    def initialize x= 0, y= 0, z= 0
        @x, @y, @z = x, y, z
    end
end