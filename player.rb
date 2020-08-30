class Player
    attr_reader :position, :width, :height

    def initialize (map:)
        @width = @height = 40
        @vy = 0
        @map = map
        map.player_location*50
        @position = map.player_location
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
        a = (!@map.solid?(@position.x + x, @position.y + y) && !@map.solid?(@position.x + @width + x , @position.y + y + height))
        pp [@map.solid?(@position.x + x, @position.y + y), @map.solid?(@position.x + @width + x , @position.y + y + height), a]
        a
    end
    def update
        move
    end
end
