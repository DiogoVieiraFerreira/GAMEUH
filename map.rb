
class Tiles
    GRASS = 0
    DIRT = 1
    DIRTGRASS = 2
end

class Map
    attr_reader :width, :height, :player_location, :tiles
    def initialize filename
        @tileset = Gosu::Image.load_tiles('media/tileset2.png', 60, 60, tileable: true)
        lines = File.readlines(filename).map { |line| line.chomp }

        @height = lines.size
        @width = lines.first.size
        @tiles = Array.new(@width) do |x|
            Array.new(@height) do |y|
                case lines[y][x]
                    when '"'
                        Tiles::GRASS
                    when '*'
                        Tiles::DIRTGRASS
                    when '#'
                        Tiles::DIRT
                    when 'P'
                        @player_location = Vector2.new y, x
                        nil
                    else
                        nil
                end
            end
        end
    end

    def draw
        @height.times do |y|
            @width.times do |x|
                value = @tiles[x][y]
                @tileset[value].draw(x * 50 - 5, y * 50 - 5, 0) if value
            end
        end
    end
    # Solid at a given pixel position?
    def solid?(x, y)
        if @tiles[x/50][y/50]
            true
        else
            false
        end
    end
end
