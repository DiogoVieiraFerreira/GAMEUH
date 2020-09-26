require_relative "vector2"
class Ennemy
    attr_reader :position, :width, :height

    def initialize (position, map)
        @offset = 2
        @width = @height = 40
        @vy = 0
        @map = map
        @position = position*50       

        @move = :left
        raise Exception.new("position not found...") unless @position.x && @position.y
    end

    def move
        x = 0
        x = (@move == :left) ? -5 : 5
        if x > 0
            @direction = :right
            x.times do 
                if can_move?(1, 0) 
                     @position.x += 1 
                else
                    @move = :left
                end 
            end
        elsif x < 0
            @direction = :left
            (-x).times do
                if can_move?(-1, 0) 
                    @position.x -= 1 
                else
                    @move = :right
                end 
            end 
        end
    end
    def can_move?(x, y)
        available=false
        case @direction
            when :right
                available ||= @map.collapse?(@position.x + x + @width, @position.y + y)
                available ||= @map.collapse?(@position.x + x + @width, @position.y + y + height)
            when :left
                available ||= @map.collapse?(@position.x-x-@offset, @position.y + y)
                available ||= @map.collapse?(@position.x-x-@offset, @position.y + y + height)
            when :down
                available ||= @map.collapse?(@position.x, @position.y - y + @height + @offset)
                available ||= @map.collapse?(@position.x + @width, @position.y - y + @height + @offset)
            when :up
                available ||= @map.collapse?(@position.x, @position.y + y - @offset)
                available ||= @map.collapse?(@position.x + @width, @position.y + y - @offset)
        end
        
        !available
    end
    def update
        move
    end
end
