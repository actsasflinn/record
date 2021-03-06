class LuckyRecord::Insert
  alias Params = Hash(Symbol, String) | Hash(Symbol, String?) | Hash(Symbol, Nil)

  def initialize(@table : Symbol, @params : Params)
  end

  def statement
    "insert into #{@table}(#{fields}) values(#{values_placeholders}) returning *"
  end

  def args
    @params.values
  end

  private def fields
    @params.keys.join(", ")
  end

  private def values_placeholders
    @params.values.map_with_index do |_value, index|
      "$#{index + 1}"
    end.join(", ")
  end
end
