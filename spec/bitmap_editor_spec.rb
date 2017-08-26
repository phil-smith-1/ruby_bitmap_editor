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

  end

  describe '#vertical_segment' do

  end

  describe '#horizontal_segment' do

  end

  describe '#output_canvas' do

  end
end