require_relative '../lib/bitmap_editor.rb'

RSpec.describe BitmapEditor do
  subject { BitmapEditor.new }
  describe '#run' do
    it 'returns an error if no file is provided' do
      expect(STDOUT).to receive(:puts).with('please provide correct file')
      subject.run nil
    end

    it 'returns an error if the provided file does not exist' do
      expect(STDOUT).to receive(:puts).with('please provide correct file')
      subject.run('fake_file.txt')
    end

    it 'returns the correct output when a file of commands is used' do
      expect(STDOUT).to receive(:puts).with('OOOOO')
      expect(STDOUT).to receive(:puts).with('OOZZZ')
      expect(STDOUT).to receive(:puts).with('AWOOO')
      expect(STDOUT).to receive(:puts).with('OWOOO')
      expect(STDOUT).to receive(:puts).with('OWOOO')
      expect(STDOUT).to receive(:puts).with('OWOOO')
      subject.run('../spec/support/fixtures/all_commands.txt')
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
      subject.instance_variable_set(:@canvas, [['C', 'A', 'R'], ['W', 'O', 'W'], ['Y', 'E', 'A']])
      subject.clear_canvas
      expect(subject.instance_variable_get(:@canvas)).to eq([['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']])
    end
  end

  describe '#colour_pixel' do
    it 'returns an error if either of the first two parameters is not an integer' do
      subject.instance_variable_set(:@canvas, [['C', 'A', 'R'], ['W', 'O', 'W'], ['Y', 'E', 'A']])
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel. First two parameters must be whole numbers.').exactly(3).times
      subject.colour_pixel('h', 'i', 'C')
      subject.colour_pixel(1, 'i', 'C')
      subject.colour_pixel('h', 1, 'C')
    end

    it 'returns an error if either of the first two parameters is less than 1' do
      subject.instance_variable_set(:@canvas, [['C', 'A', 'R'], ['W', 'O', 'W'], ['Y', 'E', 'A']])
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel. First two parameters must be greater than zero.').twice
      subject.colour_pixel(0, 1, 'C')
      subject.colour_pixel(1, 0, 'C')
    end

    it 'returns an error if the selected coordinate does not exist on the canvas' do
      subject.instance_variable_set(:@canvas, [['C', 'A', 'R'], ['W', 'O', 'W'], ['Y', 'E', 'A']])
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel, as it does not exist. Please choose between (1, 1) and (3, 3)').exactly(3).times
      subject.colour_pixel(1, 4, 'C')
      subject.colour_pixel(4, 1, 'C')
      subject.colour_pixel(4, 4, 'C')
    end

    it 'returns an error if the third parameter is not a string' do
      subject.instance_variable_set(:@canvas, [['C', 'A', 'R'], ['W', 'O', 'W'], ['Y', 'E', 'A']])
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel. The third parameters must be a single character, A-Z.')
      subject.colour_pixel(1, 2, 'colour')
    end

    it 'returns an error if the canvas has not been created' do
      subject.instance_variable_set(:@canvas, [])
      expect(STDOUT).to receive(:puts).with('Please create a canvas first.')
      subject.colour_pixel(1, 1, 'C')
    end

    it 'changes the selected pixel to the requested colour' do
      subject.instance_variable_set(:@canvas, [['C', 'A', 'R'], ['W', 'O', 'W'], ['Y', 'E', 'A']])
      subject.colour_pixel(3, 3, 'P')
      expect(subject.instance_variable_get(:@canvas)).to eq([['C', 'A', 'R'], ['W', 'O', 'W'], ['Y', 'E', 'P']])
    end
  end

  describe '#vertical_segment' do

  end

  describe '#horizontal_segment' do

  end

  describe '#output_canvas' do

  end
end