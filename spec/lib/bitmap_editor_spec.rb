require_relative '../../lib/bitmap_editor.rb'

RSpec.describe BitmapEditor do
  subject { BitmapEditor.new }

  def set_canvas
    subject.instance_variable_set(:@canvas, [%w[C A R], %w[W O W], %w[Y E A]])
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
      expect(STDOUT).to receive(:puts).with('Cannot create canvas. Both parameters must be whole numbers and cannot be zero.').exactly(3).times
      subject.create_canvas('Ihi')
      subject.create_canvas('I1i')
      subject.create_canvas('Ih1')
    end

    it 'sets the correct canvas' do
      subject.create_canvas('I23')
      expect(subject.instance_variable_get(:@canvas)).to eq([%w[O O], %w[O O], %w[O O]])
    end
  end

  describe '#clear_canvas' do
    it 'sets every pixel on the canvas to O' do
      set_canvas
      subject.clear_canvas
      expect(subject.instance_variable_get(:@canvas)).to eq([%w[O O O], %w[O O O], %w[O O O]])
    end
  end

  describe '#colour_pixel' do
    it 'returns an error if either of the first two parameters are not integers or are zero' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). First 2 parameters must be whole numbers and cannot be zero.').exactly(5).times
      subject.colour_pixel('LhiC')
      subject.colour_pixel('L1iC')
      subject.colour_pixel('Lh1C')
      subject.colour_pixel('L01C')
      subject.colour_pixel('L10C')
    end

    it 'returns an error if the selected coordinate does not exist on the canvas' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour selected pixel(s), as at least one does not exist. Please stay between (1, 1) and (3, 3)').exactly(3).times
      subject.colour_pixel('L14C')
      subject.colour_pixel('L41C')
      subject.colour_pixel('L44C')
    end

    it 'returns an error if the third parameter is not a string' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). The final parameter must be a single character, A-Z.')
      subject.colour_pixel('L122')
    end

    it 'returns an error if the canvas has not been created' do
      subject.instance_variable_set(:@canvas, [])
      expect(STDOUT).to receive(:puts).with('Please create a canvas first.')
      subject.colour_pixel('L11C')
    end

    it 'changes the selected pixel to the requested colour' do
      set_canvas
      subject.colour_pixel('L33P')
      expect(subject.instance_variable_get(:@canvas)).to eq([%w[C A R], %w[W O W], %w[Y E P]])
    end
  end

  describe '#vertical_segment' do
    it 'returns an error if either of the first three parameters are not integers or are zero' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). First 3 parameters must be whole numbers and cannot be zero.').exactly(7).times
      subject.vertical_segment('VhinC')
      subject.vertical_segment('V1i1C')
      subject.vertical_segment('Vh11C')
      subject.vertical_segment('V1inC')
      subject.vertical_segment('V011C')
      subject.vertical_segment('V101C')
      subject.vertical_segment('V110C')
    end

    it 'returns an error if the selected coordinates do not exist on the canvas' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour selected pixel(s), as at least one does not exist. Please stay between (1, 1) and (3, 3)').exactly(4).times
      subject.vertical_segment('V141C')
      subject.vertical_segment('V411C')
      subject.vertical_segment('V114C')
      subject.vertical_segment('V444C')
    end

    it 'returns an error if the fourth parameter is not a string' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). The final parameter must be a single character, A-Z.')
      subject.vertical_segment('V1234')
    end

    it 'returns an error if the canvas has not been created' do
      subject.instance_variable_set(:@canvas, [])
      expect(STDOUT).to receive(:puts).with('Please create a canvas first.')
      subject.vertical_segment('V111C')
    end

    it 'changes the selected pixels to the requested colour' do
      set_canvas
      subject.vertical_segment('V212P')
      expect(subject.instance_variable_get(:@canvas)).to eq([%w[C P R], %w[W P W], %w[Y E A]])
    end
  end

  describe '#horizontal_segment' do
    it 'returns an error if either of the first three parameters are not integers or are zero' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). First 3 parameters must be whole numbers and cannot be zero.').exactly(7).times
      subject.horizontal_segment('HhinC')
      subject.horizontal_segment('H1i1C')
      subject.horizontal_segment('Hh11C')
      subject.horizontal_segment('H1inC')
      subject.horizontal_segment('H011C')
      subject.horizontal_segment('H101C')
      subject.horizontal_segment('H110C')
    end

    it 'returns an error if the selected coordinates do not exist on the canvas' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour selected pixel(s), as at least one does not exist. Please stay between (1, 1) and (3, 3)').exactly(4).times
      subject.horizontal_segment('H141C')
      subject.horizontal_segment('H411C')
      subject.horizontal_segment('H114C')
      subject.horizontal_segment('H444C')
    end

    it 'returns an error if the fourth parameter is not a string' do
      set_canvas
      expect(STDOUT).to receive(:puts).with('Cannot colour pixel(s). The final parameter must be a single character, A-Z.')
      subject.horizontal_segment('H1234')
    end

    it 'returns an error if the canvas has not been created' do
      subject.instance_variable_set(:@canvas, [])
      expect(STDOUT).to receive(:puts).with('Please create a canvas first.')
      subject.horizontal_segment('H111C')
    end

    it 'changes the selected pixels to the requested colour' do
      set_canvas
      subject.horizontal_segment('H122P')
      expect(subject.instance_variable_get(:@canvas)).to eq([%w[C A R], %w[P P W], %w[Y E A]])
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
