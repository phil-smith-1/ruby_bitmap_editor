require_relative '../../lib/bitmap_editor.rb'

RSpec.describe BitmapEditor do
  subject { BitmapEditor.new }

  def set_canvas
    subject.instance_variable_set(:@canvas, [%w[A B C], %w[D E F], %w[G H I], %w[J K L]])
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
    it 'returns an error if either of the parameters are not integers, zero or greater than 250' do
      expect(STDOUT).to receive(:puts).with('Cannot create canvas. Parameters must be whole numbers between 1 and 250.').exactly(5).times
      subject.create_canvas(%w[I h i])
      subject.create_canvas(%w[I 1 i])
      subject.create_canvas(%w[I h 1])
      subject.create_canvas(%w[I 251 1])
      subject.create_canvas(%w[I 250 0])
    end

    it 'sets the correct canvas' do
      subject.create_canvas(%w[I 2 3])
      expect(subject.instance_variable_get(:@canvas)).to eq([%w[O O], %w[O O], %w[O O]])
    end
  end

  describe '#clear_canvas' do
    it 'sets every pixel on the canvas to O' do
      set_canvas
      subject.clear_canvas
      expect(subject.instance_variable_get(:@canvas)).to eq([%w[O O O], %w[O O O], %w[O O O], %w[O O O]])
    end
  end

  describe '#colour_pixel' do
    it 'returns an error if either of the first two parameters are not integers or are zero' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). Coordinates must be whole numbers and cannot be zero.').exactly(5).times
      subject.colour_pixel(%w[L h i C])
      subject.colour_pixel(%w[L 1 i C])
      subject.colour_pixel(%w[L h 1 C])
      subject.colour_pixel(%w[L 0 1 C])
      subject.colour_pixel(%w[L 1 0 C])
    end

    it 'returns an error if the selected coordinate does not exist on the canvas' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour selected pixel(s), as at least one does not exist. Please stay between (1, 1) and (3, 4)')
                                      .exactly(3).times
      subject.colour_pixel(%w[L 1 5 C])
      subject.colour_pixel(%w[L 4 1 C])
      subject.colour_pixel(%w[L 4 5 C])
    end

    it 'returns an error if the third parameter is not a string' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). The colour code must be a single character, A-Z.')
      subject.colour_pixel(%w[L 1 2 2])
    end

    it 'returns an error if the canvas has not been created' do
      subject.instance_variable_set(:@canvas, nil)
      expect(STDOUT).to receive(:puts).with('Please create a canvas first.')
      subject.colour_pixel(%w[L 1 1 C])
    end

    it 'changes the selected pixel to the requested colour' do
      set_canvas
      subject.colour_pixel(%w[L 3 3 P])
      expect(subject.instance_variable_get(:@canvas)).to eq([%w[A B C], %w[D E F], %w[G H P], %w[J K L]])
    end
  end

  describe '#vertical_segment' do
    it 'returns an error if either of the first three parameters are not integers or are zero' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). Coordinates must be whole numbers and cannot be zero.').exactly(7).times
      subject.vertical_segment(%w[V h i n C])
      subject.vertical_segment(%w[V 1 i 1 C])
      subject.vertical_segment(%w[V h 1 1 C])
      subject.vertical_segment(%w[V 1 i n C])
      subject.vertical_segment(%w[V 0 1 1 C])
      subject.vertical_segment(%w[V 1 0 1 C])
      subject.vertical_segment(%w[V 1 1 0 C])
    end

    it 'returns an error if the selected coordinates do not exist on the canvas' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour selected pixel(s), as at least one does not exist. Please stay between (1, 1) and (3, 4)')
                                      .exactly(3).times
      subject.vertical_segment(%w[V 1 1 5 C])
      subject.vertical_segment(%w[V 4 1 1 C])
      subject.vertical_segment(%w[V 4 4 5 C])
    end

    it 'returns an error if the fourth parameter is not a string' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). The colour code must be a single character, A-Z.')
      subject.vertical_segment(%w[V 1 2 3 4])
    end

    it 'returns an error if the canvas has not been created' do
      subject.instance_variable_set(:@canvas, nil)
      expect(STDOUT).to receive(:puts).with('Please create a canvas first.')
      subject.vertical_segment(%w[V 1 1 1 C])
    end

    it 'changes the selected pixels to the requested colour' do
      set_canvas
      subject.vertical_segment(%w[V 2 1 2 P])
      expect(subject.instance_variable_get(:@canvas)).to eq([%w[A P C], %w[D P F], %w[G H I], %w[J K L]])
    end
  end

  describe '#horizontal_segment' do
    it 'returns an error if either of the first three parameters are not integers or are zero' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). Coordinates must be whole numbers and cannot be zero.').exactly(7).times
      subject.horizontal_segment(%w[H h i n C])
      subject.horizontal_segment(%w[H 1 i 1 C])
      subject.horizontal_segment(%w[H h 1 1 C])
      subject.horizontal_segment(%w[H 1 i n C])
      subject.horizontal_segment(%w[H 0 1 1 C])
      subject.horizontal_segment(%w[H 1 0 1 C])
      subject.horizontal_segment(%w[H 1 1 0 C])
    end

    it 'returns an error if the selected coordinates do not exist on the canvas' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour selected pixel(s), as at least one does not exist. Please stay between (1, 1) and (3, 4)')
                                      .exactly(3).times
      subject.horizontal_segment(%w[H 1 4 1 C])
      subject.horizontal_segment(%w[H 1 1 5 C])
      subject.horizontal_segment(%w[H 4 4 5 C])
    end

    it 'returns an error if the fourth parameter is not a string' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). The colour code must be a single character, A-Z.')
      subject.horizontal_segment(%w[H 1 2 3 4])
    end

    it 'returns an error if the canvas has not been created' do
      subject.instance_variable_set(:@canvas, nil)
      expect(STDOUT).to receive(:puts).with('Please create a canvas first.')
      subject.horizontal_segment(%w[H 1 1 1 C])
    end

    it 'changes the selected pixels to the requested colour' do
      set_canvas
      subject.horizontal_segment(%w[H 1 2 2 P])
      expect(subject.instance_variable_get(:@canvas)).to eq([%w[A B C], %w[P P F], %w[G H I], %w[J K L]])
    end
  end

  describe '#output_canvas' do
    it 'returns an error if the canvas is empty' do
      subject.instance_variable_set(:@canvas, nil)
      expect(STDOUT).to receive(:puts).with('Please create a canvas first.')
      subject.output_canvas
    end

    it 'outputs canvas when it exists' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('ABC')
      expect(STDOUT).to receive(:puts).with('DEF')
      expect(STDOUT).to receive(:puts).with('GHI')
      expect(STDOUT).to receive(:puts).with('JKL')
      subject.output_canvas
    end
  end
end
