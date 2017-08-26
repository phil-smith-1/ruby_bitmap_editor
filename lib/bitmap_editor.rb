class BitmapEditor

  def initialize
    @canvas = []
  end

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      parsed_line = line.gsub(/\s+/, "")
      command = parsed_line[0]
      case command
      when 'I'
        create_canvas(parsed_line[1].to_i, parsed_line[2].to_i)
      when 'C'
        clear_canvas
      when 'L'
        colour_pixel(parsed_line[1].to_i, parsed_line[2].to_i, parsed_line[3])
      when 'V'
        vertical_segment(parsed_line[1].to_i, parsed_line[2].to_i, parsed_line[3].to_i, parsed_line[4])
      when 'H'
        horizontal_segment(parsed_line[1].to_i, parsed_line[2].to_i, parsed_line[3].to_i, parsed_line[4])
      when 'S'
        output_canvas
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

  def vertical_segment(x, y1, y2, colour)
    return puts 'Please create a canvas first.' if @canvas.empty?
    return puts 'Cannot colour pixels. First three parameters must be whole numbers.' if !x.is_a?(Integer) || !y1.is_a?(Integer) || !y2.is_a?(Integer)
    return puts 'Cannot colour pixels. First three parameters must be greater than zero.' if x < 1 || y1 < 1 || y2 < 1
    return puts 'Cannot colour pixels. The fourth parameters must be a single character, A-Z.' if !colour.is_a?(String) || colour.length > 1

    height = @canvas.count
    width = @canvas[0].count

    return puts "Cannot colour selected pixels, as at least one does not exist. Please stay between (1, 1) and (#{width}, #{height})" if x > width || y1 > height || y2 > height

    (y1..y2).each do |y|
      colour_pixel(x, y, colour)
    end
  end

  def horizontal_segment(x1, x2, y, colour)
    return puts 'Please create a canvas first.' if @canvas.empty?
    return puts 'Cannot colour pixels. First three parameters must be whole numbers.' if !x1.is_a?(Integer) || !x2.is_a?(Integer) || !y.is_a?(Integer)
    return puts 'Cannot colour pixels. First three parameters must be greater than zero.' if x1 < 1 || x2 < 1 || y < 1
    return puts 'Cannot colour pixels. The fourth parameters must be a single character, A-Z.' if !colour.is_a?(String) || colour.length > 1

    height = @canvas.count
    width = @canvas[0].count

    return puts "Cannot colour selected pixels, as at least one does not exist. Please stay between (1, 1) and (#{width}, #{height})" if x1 > width || x2 > width || y > height

    (x1..x2).each do |x|
      colour_pixel(x, y, colour)
    end
  end

  def output_canvas
    return puts 'Please create a canvas first.' if @canvas.empty?
    @canvas.each { |row| puts row.join }
  end
end
