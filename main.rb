require 'pp'
require 'gosu'
require_relative "map"
require_relative "vector2"
require_relative "player"
require_relative "ennemy"
class Gameuh < Gosu::Window
    def initialize
        super 1280, 720, {resizable: true}
        self.caption = "Gameuh!"
        @map = Map.new "media/map.txt" 
        @camera_x = @camera_y = 0
        @ennemies = @map.ennemies_positions.map do |position|
            Ennemy.new position, @map
        end
        puts @ennemies.count
        @player = Player.new @map

        @font = Gosu::Font.new self, Gosu::default_font_name, 20 
    end
    
    def update
        @player.update
        @ennemies.each &:update 
        
        # Scrolling follows player
        @camera_x = [[@player.position.x - self.width / 2, 0].max, @map.width * 50 - self.width].min
        @camera_y = [[@player.position.y - self.height / 2, 0].max, @map.height * 50 - self.height].min
    end
    
    def draw
        Gosu.translate(-@camera_x, -@camera_y) do
            @map.draw
            draw_rect(@player.position.x, @player.position.y, @player.width, @player.height, Gosu::Color.new(255,0,0))
            @ennemies.each do |ennemy|
                draw_rect(ennemy.position.x, ennemy.position.y, ennemy.width,ennemy.height, Gosu::Color.new(150,0,150))
            end
            @font.draw_text(Gosu.fps, @camera_x, @camera_y, 1, 1, 1, Gosu::Color::WHITE)
        end
    end

    def button_down id 
        case id
            when Gosu::KB_ESCAPE
                close
        end
    end
    def needs_cursor?
        true
    end    
end
Gameuh.new.show