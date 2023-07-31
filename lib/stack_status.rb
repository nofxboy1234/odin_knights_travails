class StackStatus
  # private

  
  public
  
  attr_reader :status
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