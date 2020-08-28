require 'pp'
require 'gosu'
require_relative "map"
class Testeuh < Gosu::Window
    def initialize
        super 1280, 720, {resizable: true}
        self.caption = "Gameuh!"
        @map = Map.new("media/map.txt")
    end
    
    def update
        
    end
    
    def draw
        @map.draw
    end

    def needs_cursor?
        true
    end    
end
Testeuh.new.show