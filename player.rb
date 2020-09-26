require_relative "vector2"
class Player
    attr_reader :position, :width, :height

    def initialize (map)
        @offset = 2
        @width = @height = 40
        @vy = 0
        @map = map
        @position = map.player_location*50
        raise Exception.new("Player without position...") unless @position.x && @position.y
    end

    def move
        x = 0
        x -= 5 if Gosu.button_down?(Gosu::KB_LEFT) || Gosu.button_down?(Gosu::KB_A)
        x += 5 if Gosu.button_down?(Gosu::KB_RIGHT) || Gosu.button_down?(Gosu::KB_D)
        if x > 0
            @direction = :right
            x.times { if can_move?(1, 0) then @position.x += 1 end }
        elsif x < 0
            @direction = :left
            (-x).times { if can_move?(-1, 0) then @position.x -= 1 end }
        end
        
        y = 0
        y -= 5 if Gosu.button_down?(Gosu::KB_UP) || Gosu.button_down?(Gosu::KB_W)
        y += 5 if Gosu.button_down?(Gosu::KB_DOWN) || Gosu.button_down?(Gosu::KB_S)
        if y > 0
            @direction = :down
            y.times { if can_move?(0, 1) then @position.y += 1 end }
        elsif y < 0
            @direction = :up
            (-y).times { if can_move?(0, -1) then @position.y -= 1 end }
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
