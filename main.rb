require 'pp'
require 'gosu'
require_relative "map"
class Gameuh < Gosu::Window
    def initialize
        super 1280, 720, {resizable: true}
        self.caption = "Gameuh!"
        @map = Map.new("media/map.txt")
        
        @camera_x = @camera_y = 0
        @player_x=0
        @player_y=0
    end
    
    def update
        
        @player_x -= 5 if Gosu.button_down? Gosu::KB_LEFT
        @player_x += 5 if Gosu.button_down? Gosu::KB_RIGHT
        @player_y -= 5 if Gosu.button_down? Gosu::KB_UP
        @player_y += 5 if Gosu.button_down? Gosu::KB_DOWN
        
        # Scrolling follows player
        @camera_x = [[@player_x - self.width / 2, 0].max, @map.width * 50 - self.width].min
        @camera_y = [[@player_y - self.height / 2, 0].max, @map.height * 50 - self.height].min
    end
    
    def draw
        Gosu.translate(-@camera_x, -@camera_y) do
            @map.draw
            draw_rect(@player_x,@player_y,20,20,Gosu::Color.new(255,0,0))
        end
    end

    def needs_cursor?
        true
    end    
end
Gameuh.new.show