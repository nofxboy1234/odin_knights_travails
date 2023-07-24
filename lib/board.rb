class Board
  attr_reader :squares, :rows, :columns

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
  end

  def squares
    return @squares if @squares

    @squares = []
    (0...rows).each do |row|
      (0...columns).each do |column|
        @squares << [row, column]
      end
    end

    @squares
  end

  def start_index
    0
  end

  def end_index
    columns - 1
  end
end
