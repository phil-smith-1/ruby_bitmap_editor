class BitmapEditor # :nodoc:
  VALID_COMMANDS = 'ICLVHS'.freeze
  COMMAND_METHODS = {
    I: :create_canvas,
    C: :clear_canvas,
    L: :colour_pixel,
    V: :vertical_segment,
    H: :horizontal_segment,
    S: :output_canvas
  }.freeze

  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exist?(file)

    File.open(file).each do |line|
      parsed_line = line.upcase.split(' ')
      command = parsed_line[0]
      VALID_COMMANDS.include?(command) ? send(COMMAND_METHODS[command.to_sym], parsed_line) : puts('unrecognised command :(')
    end
  end

  def create_canvas(args)
    width = args[1].to_i
    height = args[2].to_i
    return puts 'Cannot create canvas. Parameters must be whole numbers between 1 and 250.' unless width.between?(1, 250) && height.between?(1, 250)

    @canvas = []
    height.times do |row|
      @canvas[row] = []
      width.times { @canvas[row] << 'O' }
    end
  end

  def clear_canvas(_args = [])
    @canvas.count.times do |row|
      @canvas[row].count.times { |column| colour_pixel("L#{row + 1}#{column + 1}O") }
    end
  end

  def colour_pixel(args)
    x = args[1].to_i
    y = args[2].to_i
    colour = args[3]
    return unless canvas_exists? && numbers_correct?([x, y]) && alpha_character?(colour) && in_bounds?([[x], [y]])

    @canvas[y - 1][x - 1] = colour
  end

  def vertical_segment(args)
    x = args[1].to_i
    y1 = args[2].to_i
    y2 = args[3].to_i
    colour = args[4]
    return unless canvas_exists? && numbers_correct?([x, y1, y2]) && alpha_character?(colour) && in_bounds?([[x], [y1, y2]])

    (y1..y2).each do |y|
      colour_pixel("L#{x}#{y}#{colour}")
    end
  end

  def horizontal_segment(args)
    x1 = args[1].to_i
    x2 = args[2].to_i
    y = args[3].to_i
    colour = args[4]
    return unless canvas_exists? && numbers_correct?([x1, x2, y]) && alpha_character?(colour) && in_bounds?([[x1, x2], [y]])

    (x1..x2).each do |x|
      colour_pixel("L#{x}#{y}#{colour}")
    end
  end

  def output_canvas(_args = [])
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
        puts 'Cannot colour pixel(s). Coordinates must be whole numbers and cannot be zero.'
        return false
      end
    end
    true
  end

  def alpha_character?(character)
    unless /[A-Z]/ =~ character && character.length == 1
      puts 'Cannot colour pixel(s). The colour code must be a single character, A-Z.'
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
