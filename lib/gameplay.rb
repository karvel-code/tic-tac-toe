class GamePlay
    attr_reader :board
    def initialize
        @board = []
        9.times { @board.push(0) }
    end

    def validate(move)
        valid = true
        error = " "
        if move < 1 or move > 9
            valid = false
            error = 'Number is not between 0 and 9'
          elsif @board[move - 1].is_a? String
            valid = false
            error = 'The cell is not empty'
          end
          [valid, error]
        end

    def board_update(move, player)
        @board[move - 1] = player
    end

    def status
        winning_combo = [[0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 1, 2], [3, 4, 5], [6, 7, 8], [2, 4, 6], [0, 4, 8]].freeze
        return_value = check_winner(winning_combo)
        return return_value unless return_value.zero?

        return_value = 3 if check_board

        return_value
    end

    def check_winner(winning_combo)
        winning_combo.each do |combo|
            if combo.all? {|position| @board[position].eql? 'X'}
                return 1
            elsif combo.all? {|position| @board[position].eql? 'O'}
                return 2
            else
                return 0
            end
        end
    end

    def check_board
        @board.all? {|element| element.is_a? String}
    end

   
    # def status
    #     horizontal = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    #     vertical = [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
    #     diagonal = [[0, 4, 8], [2, 4, 6]]
    #     winning_combo = [horizontal, vertical, diagonal].flatten(1).freeze
    #     return_value = check_winner(winning_combo)
    #     return return_value unless return_value.zero? # Return if someone has won
    
    #     return_value = 3 if check_board # Checking for a draw
    
    #     return_value
    # end
end
