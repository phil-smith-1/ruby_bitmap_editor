class BitmapEditor

  def initialize
    @canvas = []
  end

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      case line
      when 'S'
          puts "There is no image"
      else
          puts 'unrecognised command :('
      end
    end
  end

  def create_canvas(width, height)
    return puts 'Cannot create canvas. Both parameters must be whole numbers.' if !width.is_a?(Integer) || !height.is_a?(Integer)

    @canvas = []
    height.times do |row|
      @canvas[row] = []
      width.times { @canvas[row] << 'O' }
    end
  end

  def clear_canvas
    @canvas.count.times do |row|
      @canvas[row].count.times { |column| colour_pixel(row + 1 , column + 1, 'O') }
    end
  end

  def colour_pixel(x, y, colour)
    return puts 'Please create a canvas first.' if @canvas.empty?
    return puts 'Cannot colour pixel. First two parameters must be whole numbers.' if !x.is_a?(Integer) || !y.is_a?(Integer)
    return puts 'Cannot colour pixel. First two parameters must be greater than zero.' if x < 1 || y < 1
    return puts 'Cannot colour pixel. The third parameters must be a single character, A-Z.' if !colour.is_a?(String) || colour.length > 1

    height = @canvas.count
    width = @canvas[0].count

    return puts "Cannot colour pixel, as it does not exist. Please choose between (1, 1) and (#{width}, #{height})" if x > width || y > height

    @canvas[y - 1][x - 1] = colour
  end
end
