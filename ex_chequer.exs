defmodule ExChequer do

  #--------------------------------------------------------------------------------------------------------------------
  # Scenarios for printing units
  # when the unit index is 0 lookup unit
  # when the unit index is greater than zero and length < 1
  # -- unit should only be looked up once
  #--------------------------------------------------------------------------------------------------------------------
  # @single_digit_numbers %{"0" => "ZERO", "1" => "ONE", "2" => "TWO", "3" => "THREE", "4" => "FOUR",
  #                         "5" => "FIVE", "6" => "SIX", "7" => "SEVEN", "8" => "EIGHT", "9" => "NINE"}
  # @tens %{}
  @units_map %{0 => "HUNDRED", 1 => "THOUSAND", 2 => "MILLION", -1 => ""}

  @word_map %{
      "0" => %{1 => "", 2 => ""}, "1" => %{1 => "ONE", 2 => nil}, 2 => %{1 => "TWO", 2 => "TWENTY"},
      "3" => %{1 => "THREE", 2 => "THIRTY"}, "4" => %{1 => "FOUR", 2 => "FORTY"}, "5" => %{1 => "FIVE", 2 => "FIFTY"},
      "6" => %{1 => "SIX", 2 => "SIXTY"}, "7" => %{1 => "SEVEN", 2 => "SEVENTY"}, "8" => %{1 => "EIGHT", 2 => "EIGHTY"},
      "9" => %{1 => "NINE", 2 => "NINETY"}
  }

  @double_digit_numbers %{"10" => "TEN", "11" => "ELEVEN", "12" => "TWELVE", "13" => "THIRTEEN", "14" => "FOURTEEN",
                          "15" => "FIFTEEN", "16" => "SIXTEEN", "17" => "SEVENTEEN", "18" => "EIGHTEEN", "19" => "NINETEEN"}
  # def convert_amount_to_text(amount) when is_number, do: convert_amount_to_text(to_string(amount))

  #---------------------------------------------------------------------------------------------------
  # todo
  # group by three or track by the length
  # write logic to subtract position - 1 when rem is 0
  #---------------------------------------------------------------------------------------------------

  # # split by dollars and cents
  def convert_amount_to_text(amount) do
      # [dollars | [ cents | []]] = String.split(amount, ".")
      [dollars | cents ] = String.split(amount, ".")
      Enum.reduce(String.graphemes(dollars), String.length(dollars), fn(digit, index) ->
        parse_amount(digit, {rem(index, 3), div(index, 3)})
      end)
      # parse_amount(amount)
  end

  # ie position is given by div and number is given by rem
  # if number return nil look up double digit numbers
  # 438
  # defp parse_amount(number, {amount_position, word_index})

  def parse_amount(number, {0, word_index}) do
    # @word_map[number]
    @word_map[number][word_index] <> " " <> @units_map[word_index - 1]
  end

  def parse_amount(number, {unit_index, 0}) do
    @word_map[number][unit_index]
  end


end


# digits rem div
# hundreds
# 1 {1, 0}
# 2 {2, 0}
# 3 {0, 1}
# thousands
# 4 {1, 1}
# 5 {2, 1}
# 6 {0, 2}
# million
# 7 {1, 2}
# 8 {2, 2}
# 9 {0, 3}

#position
# digits div rem
# hundreds
# 1 {0, 1}
# 2 {0, 2}
# 3 {1, 0}
# thousands
# 4 {1, 1}
# 5 {1, 2}
# 6 {2, 0}
# million
# 7 {2, 1}
# 8 {2, 2}
# 9 {3, 0}



