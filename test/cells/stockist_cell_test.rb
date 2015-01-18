require 'test_helper'

class StockistCellTest < Cell::TestCase
  test "show" do
    invoke :show
    assert_select 'p'
  end


end
