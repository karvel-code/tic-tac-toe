class GamePlay
    attr_reader :board
    def initialize
        @board = []
        9.times { @board.push(0) }
    end

    def validate(move)
        valid = true
        error = " "
        case valid
        when move < 1 && move > 9
            valid = false
            error "The number not in the range of 1 - 9"
        when @board[move - 1].is_a? 
            valid = false
            error "The position has already been played/occupied"
        else
            valid = true
        end
    end

    def board_update(move, player)
        @board[move - 1] = player
    end

    def check_winner(winning_combo)
        winning_combo.each do |combo|
            if combo.all? {|position| @board[position] == "X"}
                return 1
            elsif combo.all? {|position| @board[position] == "O"}
                return 2
            end
        end
        return 0
    end

    def check_board
        @board.all? {|element| element.is_a?String}
    end

    def status
        winning_combo = [[0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 1, 2], [3, 4, 5], [6, 7, 8], [2, 4, 6], [0, 4, 8]].freeze
        return_value = check_winner(winning_combo)
        return return_value unless return_value.zero?

        return 3 if check_board

        return_value
    end
end
