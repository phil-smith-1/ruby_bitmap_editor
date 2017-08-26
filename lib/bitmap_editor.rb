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

  def create_canvas(w, h)
    return puts 'Cannot create canvas. Both parameters must be whole numbers.' if !w.is_a?(Integer) || !h.is_a?(Integer)

    @canvas = []
    h.times do |row|
      @canvas[row] = []
      w.times { @canvas[row] << 'O' }
    end
  end

  def clear_canvas
    @canvas.count.times do |row|
      @canvas[row].count.times { |column| @canvas[row][column] = 'O' }
    end
  end
end
