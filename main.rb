require 'gosu'
class Testeuh < Gosu::Window
    def initialize
        super 1280, 720, {resizable: true}
        self.caption = "Gameuh!"
    end
    
    def update
        
    end
    
    def draw
        
    end
    def needs_cursor?
        true
    end    
end
Testeuh.new.show