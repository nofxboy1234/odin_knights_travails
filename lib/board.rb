# frozen_string_literal: true

class Board
  attr_reader :rows, :columns

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
  end

  def rows_start_index
    0
  end

  def rows_end_index
    rows - 1
  end

  def columns_start_index
    0
  end

  def columns_end_index
    columns - 1
  end
end
