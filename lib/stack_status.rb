class StackStatus
  private

  attr_reader :status

  public

  attr_writer :status

  def initialize(status)
    @status = status
  end

  def unwinding?
    status == 'unwinding'
  end

  def winding?
    status == 'winding'
  end
end