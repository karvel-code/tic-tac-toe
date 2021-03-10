require_relative '../lib/gameplay'
require_relative '../lib/player'

describe GamePlay do
  let(:subject) { GamePlay.new }
  describe '#initialize' do
    it 'intializes an empty tictactoe board with nine zeros ' do
      expect(subject.board).to eq([0, 0, 0, 0, 0, 0, 0, 0, 0])
    end
  end

  describe '#validate' do
    it 'gives an error when move is not provided as an argument' do
      expect { subject.validate }.to raise_error(ArgumentError)
    end
    it 'returns true if a move is valid' do
      return_value = subject.validate(5)
      expect(return_value[0]).to eq(true)
    end
    it 'returns false when the element of an array is less then one' do
      return_value = subject.validate(-1)
      expect(return_value[0]).to eq(false)
    end
    it 'returns false when an element of an array is more than nine' do
      return_value = subject.validate(10)
      expect(return_value[0]).to eq(false)
    end
    it 'returns false it the cell in the board is already occupied' do
      subject.board_update(2, 'x')
      return_value = subject.validate(2)
      expect(return_value[0]).to eq(false)
    end
  end

  describe '#board_update' do
    it 'returns the users input minus one to match the array/board values' do
      subject.board_update(8, 'X')
      expect(subject.board[7]).to eq('X')
    end
  end

  describe '#status' do
    context 'player one' do
      it 'returns when player one has won horizontally' do
        subject.board_update(1, 'X')
        subject.board_update(2, 'X')
        subject.board_update(3, 'X')

        expect(subject.status).to eql(1)
      end

      it 'returns when player one has won vertically' do
        subject.board_update(2, 'X')
        subject.board_update(5, 'X')
        subject.board_update(8, 'X')

        expect(subject.status).to eql(1)
      end

      it 'returns when player one has won diagonally' do
        subject.board_update(1, 'X')
        subject.board_update(5, 'X')
        subject.board_update(9, 'X')

        expect(subject.status).to eql(1)
      end
    end

    context 'player two' do
      it 'returns when player one has won horizontally' do
        subject.board_update(7, 'O')
        subject.board_update(8, 'O')
        subject.board_update(9, 'O')

        expect(subject.status).to eql(2)
      end

      it 'returns when player one has won vertically' do
        subject.board_update(3, 'O')
        subject.board_update(6, 'O')
        subject.board_update(9, 'O')

        expect(subject.status).to eql(2)
      end

      it 'returns when player two has won diagonally' do
        subject.board_update(3, 'O')
        subject.board_update(5, 'O')
        subject.board_update(7, 'O')

        expect(subject.status).to eql(2)
      end
    end

    context 'draw' do
      it 'return value is three when the game ends in a draw' do
        subject.board_update(1, 'X')
        subject.board_update(2, 'O')
        subject.board_update(3, 'X')
        subject.board_update(4, 'X')
        subject.board_update(5, 'O')
        subject.board_update(6, 'X')
        subject.board_update(7, 'O')
        subject.board_update(8, 'X')
        subject.board_update(9, 'O')

        expect(subject.status).to eq(3)
      end

      context ' No victory or draw scenario' do
        it 'returns 0 if no one has won and board is not full' do
          subject.board_update(1, 'X')
          subject.board_update(2, 'O')
          subject.board_update(3, 'X')
          subject.board_update(7, 'O')
          subject.board_update(8, 'X')
          expect(subject.status).to eq(0)
        end
      end
    end
  end
  describe Player do
    subject { Player.new('player2', 'O') }
    describe '#initialize' do
      it 'initializes the name of the player' do
        expect(subject.name).to eq('player2')
      end
      it 'initializes the symbol of the player' do
        expect(subject.symbol).to eq('O')
      end
      it 'does not create the object if required attribute player_symbol is missing' do
        expect { Player.new('second') }.to raise_error(ArgumentError)
      end
    end
  end
end
