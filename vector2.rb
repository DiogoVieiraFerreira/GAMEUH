class Vector2
    attr_accessor :x, :y
    def initialize x= 0, y= 0
        @x, @y = x, y
    end
    def * value
        @x *= value
        @y *= value
        self
    end
end