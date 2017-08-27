class BitmapEditor # :nodoc:
  def initialize
    @canvas = []
  end

  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exist?(file)

    File.open(file).each do |line|
      parsed_line = line.gsub(/\s+/, '')
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
      @canvas[row].count.times { |column| colour_pixel(row + 1, column + 1, 'O') }
    end
  end

  def colour_pixel(x, y, colour)
    return unless canvas_exists?
    return unless numbers_correct?([x, y])
    return unless single_character?(colour)
    return unless in_bounds?([[x], [y]])

    @canvas[y - 1][x - 1] = colour
  end

  def vertical_segment(x, y1, y2, colour)
    return unless canvas_exists?
    return unless numbers_correct?([x, y1, y2])
    return unless single_character?(colour)
    return unless in_bounds?([[x], [y1, y2]])

    (y1..y2).each do |y|
      colour_pixel(x, y, colour)
    end
  end

  def horizontal_segment(x1, x2, y, colour)
    return unless canvas_exists?
    return unless numbers_correct?([x1, x2, y])
    return unless single_character?(colour)
    return unless in_bounds?([[x1, x2], [y]])

    (x1..x2).each do |x|
      colour_pixel(x, y, colour)
    end
  end

  def output_canvas
    return unless canvas_exists?
    @canvas.each { |row| puts row.join }
  end

  private

  def canvas_exists?
    if @canvas.empty?
      puts 'Please create a canvas first.'
      return false
    end
    true
  end

  def numbers_correct?(args)
    args.each do |parameter|
      unless parameter.is_a?(Integer) && !parameter.zero?
        puts "Cannot colour pixel(s). First #{args.count} parameters must be whole numbers and cannot be zero."
        return false
      end
    end
    true
  end

  def single_character?(character)
    unless character.is_a?(String) && character.length == 1
      puts 'Cannot colour pixel(s). The final parameter must be a single character, A-Z.'
      return false
    end
    true
  end

  def in_bounds?(args)
    height = @canvas.count
    width = @canvas[0].count
    error = false

    args[0].each { |num| error = true if num > width }
    args[1].each { |num| error = true if num > height }

    if error
      puts "Cannot colour selected pixel(s), as at least one does not exist. Please stay between (1, 1) and (#{width}, #{height})"
      return false
    end
    true
  end
end
