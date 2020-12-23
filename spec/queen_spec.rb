require 'rspec/autorun'

describe Queen do

  describe 'valid_move?' do
    context 'queen is making a diagonal move' do

      xit 'returns true if finish square contains opponents piece' do
      end

      xit 'returns false if finish square contains players own piece' do
      end

      xit 'returns true if finish square is empty' do
      end
    end

    context 'queen is making  move horizontal or vertical move' do

      xit 'returns true if finish square contains opponents piece' do
      end

      xit 'returns false if finish square contains players own piece' do
      end

      xit 'returns true if finish square is empty' do
      end
    end
  end

  describe 'possible_moves' do
    context 'for a given start coodinate' do
      xit 'returns an array of horizontal moves' do
      end

      xit 'returns an array of vertical moves' do
      end

      xit 'returns an array of diagonal moves' do
      end

      xit 'returns an array of antediagonal moves' do
      end
    end
  end

  describe 'space_between_diagonals' do
    context 'when queen is moving on the same diagonal' do
      xit 'returns true if space between start and finish squares' do
      end

      xit 'returns false if players own piece between start and finish squares' do
      end

      xit 'returns false opponents pieces between start and finish sqaures' do
      end
    end

    context 'when queen is moving on the same antediagonal' do
      xit 'returns true if space between start and finish squares' do
      end

      xit 'returns false if players own piece between start and finish squares' do
      end

      xit 'returns false opponents pieces between start and finish sqaures' do
      end
    end
  end

  describe 'space_between_columns' do
    context 'when queen is moving on the same column' do
      xit 'returns true if space between start and finish squares' do
      end

      xit 'returns false if players own piece between start and finish squares' do
      end

      xit 'returns false opponents pieces between start and finish sqaures' do
      end
    end
  end

  describe 'space_between_rows' do
    context 'when queen is moving on the same row' do
      xit 'returns true if space between start and finish squares' do
      end

      xit 'returns false if players own piece between start and finish squares' do
      end

      xit 'returns false opponents pieces between start and finish sqaures' do
      end
    end
  end

end