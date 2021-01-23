module Gosu
  module Tiled
    class Map
      attr_reader :tilesets, :layers, :width, :height, :tilewidth, :tileheight, :pixelwidth, :pixelheight

      def initialize(window, data, data_dir, options = {})
        zoom = options[:zoom] || 1
        grid = options[:grid] || false
        @window = window
        @data = data
        @data_dir = data_dir
        @tilewidth = data['tilewidth'] * zoom
        @tileheight = data['tileheight'] * zoom
        @width = data['width']
        @height = data['height']
        @pixelwidth = data['width'] * @tilewidth
        @pixelheight = data['height'] * @tileheight

        @tilesets = Tilesets.new(data['tilesets'], data_dir)

        @layers = Layers.new(window,
                             data['layers'],
                             width: @pixelwidth,
                             height: @pixelheight,
                             tile_width: data['tilewidth'],
                             tile_height: data['tileheight'], zoom: zoom, grid: grid)
      end

      def draw(offset_x, offset_y)
        @layers.each do |layer|
          layer.draw(offset_x, offset_y, tilesets)
        end
      end
    end
  end
end
