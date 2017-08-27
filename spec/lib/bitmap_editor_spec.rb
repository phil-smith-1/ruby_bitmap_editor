require_relative '../lib/bitmap_editor.rb'

RSpec.describe BitmapEditor do
  subject { BitmapEditor.new }

  def set_canvas
    subject.instance_variable_set(:@canvas, [['C', 'A', 'R'], ['W', 'O', 'W'], ['Y', 'E', 'A']])
  end

  describe '#run' do
    it 'returns an error if no file is provided' do
      expect(STDOUT).to receive(:puts).with('please provide correct file')
      subject.run nil
    end

    it 'returns an error if the provided file does not exist' do
      expect(STDOUT).to receive(:puts).with('please provide correct file')
      subject.run('fake_file.txt')
    end

    it 'returns an error for invalid commands' do
      expect(STDOUT).to receive(:puts).with('unrecognised command :(').exactly(4).times
      subject.run('spec/support/fixtures/invalid_commands.txt')
    end

    it 'returns the correct output when a file of commands is used' do
      expect(STDOUT).to receive(:puts).with('OOOOO')
      expect(STDOUT).to receive(:puts).with('OOZZZ')
      expect(STDOUT).to receive(:puts).with('AWOOO')
      expect(STDOUT).to receive(:puts).with('OWOOO')
      expect(STDOUT).to receive(:puts).with('OWOOO')
      expect(STDOUT).to receive(:puts).with('OWOOO')
      subject.run('spec/support/fixtures/all_commands.txt')
    end
  end

  describe '#create_canvas' do
    it 'returns an error if either of the parameters are not intgers' do
      expect(STDOUT).to receive(:puts).with('Cannot create canvas. Both parameters must be whole numbers.').exactly(3).times
      subject.create_canvas('h', 'i')
      subject.create_canvas(1, 'i')
      subject.create_canvas('h', 1)
    end

    it 'sets the correct canvas' do
      subject.create_canvas(2, 3)
      expect(subject.instance_variable_get(:@canvas)).to eq([['O', 'O'], ['O', 'O'], ['O', 'O']])
    end
  end

  describe '#clear_canvas' do
    it 'sets every pixel on the canvas to O' do
      set_canvas
      subject.clear_canvas
      expect(subject.instance_variable_get(:@canvas)).to eq([['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']])
    end
  end

  describe '#colour_pixel' do
    it 'returns an error if either of the first two parameters are not integers or are zero' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). First 2 parameters must be whole numbers and cannot be zero.').exactly(5).times
      subject.colour_pixel('h', 'i', 'C')
      subject.colour_pixel(1, 'i', 'C')
      subject.colour_pixel('h', 1, 'C')
      subject.colour_pixel(0, 1, 'C')
      subject.colour_pixel(1, 0, 'C')
    end

    it 'returns an error if the selected coordinate does not exist on the canvas' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour selected pixel(s), as at least one does not exist. Please stay between (1, 1) and (3, 3)').exactly(3).times
      subject.colour_pixel(1, 4, 'C')
      subject.colour_pixel(4, 1, 'C')
      subject.colour_pixel(4, 4, 'C')
    end

    it 'returns an error if the third parameter is not a string' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). The final parameter must be a single character, A-Z.')
      subject.colour_pixel(1, 2, 'colour')
    end

    it 'returns an error if the canvas has not been created' do
      subject.instance_variable_set(:@canvas, [])
      expect(STDOUT).to receive(:puts).with('Please create a canvas first.')
      subject.colour_pixel(1, 1, 'C')
    end

    it 'changes the selected pixel to the requested colour' do
      set_canvas
      subject.colour_pixel(3, 3, 'P')
      expect(subject.instance_variable_get(:@canvas)).to eq([['C', 'A', 'R'], ['W', 'O', 'W'], ['Y', 'E', 'P']])
    end
  end

  describe '#vertical_segment' do
    it 'returns an error if either of the first three parameters are not integers or are zero' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). First 3 parameters must be whole numbers and cannot be zero.').exactly(7).times
      subject.vertical_segment('h', 'i', 'n', 'C')
      subject.vertical_segment(1, 'i', 1, 'C')
      subject.vertical_segment('h', 1, 1, 'C')
      subject.vertical_segment(1, 'i', 'n', 'C')
      subject.vertical_segment(0, 1, 1, 'C')
      subject.vertical_segment(1, 0, 1, 'C')
      subject.vertical_segment(1, 1, 0, 'C')
    end

    it 'returns an error if the selected coordinates do not exist on the canvas' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour selected pixel(s), as at least one does not exist. Please stay between (1, 1) and (3, 3)').exactly(4).times
      subject.vertical_segment(1, 4, 1, 'C')
      subject.vertical_segment(4, 1, 1, 'C')
      subject.vertical_segment(1, 1, 4, 'C')
      subject.vertical_segment(4, 4, 4, 'C')
    end

    it 'returns an error if the fourth parameter is not a string' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). The final parameter must be a single character, A-Z.')
      subject.vertical_segment(1, 2, 3, 'colour')
    end

    it 'returns an error if the canvas has not been created' do
      subject.instance_variable_set(:@canvas, [])
      expect(STDOUT).to receive(:puts).with('Please create a canvas first.')
      subject.vertical_segment(1, 1, 1, 'C')
    end

    it 'changes the selected pixels to the requested colour' do
      set_canvas
      subject.vertical_segment(2, 1, 2, 'P')
      expect(subject.instance_variable_get(:@canvas)).to eq([['C', 'P', 'R'], ['W', 'P', 'W'], ['Y', 'E', 'A']])
    end
  end

  describe '#horizontal_segment' do
    it 'returns an error if either of the first three parameters are not integers or are zero' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). First 3 parameters must be whole numbers and cannot be zero.').exactly(7).times
      subject.horizontal_segment('h', 'i', 'n', 'C')
      subject.horizontal_segment(1, 'i', 1, 'C')
      subject.horizontal_segment('h', 1, 1, 'C')
      subject.horizontal_segment(1, 'i', 'n', 'C')
      subject.horizontal_segment(0, 1, 1, 'C')
      subject.horizontal_segment(1, 0, 1, 'C')
      subject.horizontal_segment(1, 1, 0, 'C')
    end

    it 'returns an error if the selected coordinates do not exist on the canvas' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour selected pixel(s), as at least one does not exist. Please stay between (1, 1) and (3, 3)').exactly(4).times
      subject.horizontal_segment(1, 4, 1, 'C')
      subject.horizontal_segment(4, 1, 1, 'C')
      subject.horizontal_segment(1, 1, 4, 'C')
      subject.horizontal_segment(4, 4, 4, 'C')
    end

    it 'returns an error if the fourth parameter is not a string' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). The final parameter must be a single character, A-Z.')
      subject.horizontal_segment(1, 2, 3, 'colour')
    end

    it 'returns an error if the canvas has not been created' do
      subject.instance_variable_set(:@canvas, [])
      expect(STDOUT).to receive(:puts).with('Please create a canvas first.')
      subject.horizontal_segment(1, 1, 1, 'C')
    end

    it 'changes the selected pixels to the requested colour' do
      set_canvas
      subject.horizontal_segment(1, 2, 2, 'P')
      expect(subject.instance_variable_get(:@canvas)).to eq([['C', 'A', 'R'], ['P', 'P', 'W'], ['Y', 'E', 'A']])
    end
  end

  describe '#output_canvas' do
    it 'returns an error if the canvas is empty' do
      subject.instance_variable_set(:@canvas, [])
      expect(STDOUT).to receive(:puts).with('Please create a canvas first.')
      subject.output_canvas
    end

    it 'outputs canvas when it exists' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('WOW')
      expect(STDOUT).to receive(:puts).with('CAR')
      expect(STDOUT).to receive(:puts).with('YEA')
      subject.output_canvas
    end
  end
end