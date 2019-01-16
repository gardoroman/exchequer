defmodule ExChequer do

  @singles %{"0" => "", "1" => "ONE", "2" => "TWO", "3" => "THREE", "4" => "FOUR",
             "5" => "FIVE", "6" => "SIX", "7" => "SEVEN", "8" => "EIGHT", "9" => "NINE"}
  @tens %{"0" => "", "2" => "TWENTY", "3" => "THIRTY", "4" => "FORTY", "5" => "FIFTY",
          "6" => "SIXTY", "7" => "SEVENTY", "8" => "EIGHTY", "9" => "NINETY"}

  @groups %{0 => "", 1 => "THOUSAND", 2 => "MILLION", 3 => "BILLION"}

  @teens_map %{"10" => "TEN", "11" => "ELEVEN", "12" => "TWELVE", "13" => "THIRTEEN", "14" => "FOURTEEN",
               "15" => "FIFTEEN", "16" => "SIXTEEN", "17" => "SEVENTEEN", "18" => "EIGHTEEN", "19" => "NINETEEN"}

  #---------------------------------------------------------------------------
  # convert_amount_to_text/1
  # Takes a number or string representation of a number and converts
  # it to a number written out.
  # It calls helper functions that format the strings for pattern matching
  # and functions that generate the numeric text.
  #---------------------------------------------------------------------------
  def convert_amount_to_text(amount) when is_number(amount), do: convert_amount_to_text(to_string(amount))

  def convert_amount_to_text(amount) do
      [dollars | cents ] = String.split(amount, ".")
      groupings = create_number_groupings(dollars)
      group_indices = Enum.count(groupings) - 1
      {amount_to_text, _} =
        Enum.reduce(groupings, {"", group_indices}, fn(grouping, {amount_text, group_index}) ->
            group_text = process_group(grouping, group_index)
            { amount_text <> group_text, group_index - 1 }
        end)
      String.trim(amount_to_text) <> format_cents(cents)
  end

  #---------------------------------------------------------------------------
  # format_cents/1
  # Returns text the cents if the string is not empty
  #---------------------------------------------------------------------------
  defp format_cents([]), do: ""
  defp format_cents([""]), do: ""
  defp format_cents([cents]), do: " AND #{cents}/100"

  #---------------------------------------------------------------------------
  # create_number_groupings/1
  # Create grouping of three numbers.
  # Pad beginning of group with extra zeros based on
  # number of zeros needed to complete a set of three.
  # The padding is necessary to enable pattern matching
  #---------------------------------------------------------------------------
  def create_number_groupings(dollars) do
      pad_with_zeros(rem(String.length(dollars), 3)) <> dollars
      |> String.graphemes
      |> Enum.chunk_every(3)
  end

  #---------------------------------------------------------------------------
  # pad_with_zeros/1
  # Pads the string with the number of zeros needed to create a
  # group of three
  # Assumes a number between 0 and 2
  #---------------------------------------------------------------------------
  defp pad_with_zeros(0), do: ""
  defp pad_with_zeros(offset) do
      pad_size = 3 - offset
      String.duplicate("0", pad_size)
  end

  #---------------------------------------------------------------------------
  # check_for_hundreds_unit/1
  # Adds 'HUNDRED' descriptor if number in the hundreds position is not
  # equal to zero.
  #---------------------------------------------------------------------------
  defp check_for_hundreds_unit("0"), do: ""
  defp check_for_hundreds_unit(_), do: "HUNDRED "

  #---------------------------------------------------------------------------
  # process_group/2
  # Receives a list containing a number group and the group_index which is
  # used to assign the correct number descriptor from the gropus map
  #---------------------------------------------------------------------------
  defp process_group([hundreds | [ tens | [ ones | []] ] ], group_index ) do
      format_number_text(@singles[hundreds]) <>
      check_for_hundreds_unit(hundreds) <>
      format_number_text(handle_under_one_hundred(tens, ones)) <>
      format_number_text(@groups[group_index])
  end

  #---------------------------------------------------------------------------
  # handle_under_one_hundred/2
  # Uses pattern matching to select the correct number under 100.
  # It handles edge cases for numbers in the teens.
  #---------------------------------------------------------------------------
  defp handle_under_one_hundred("1", ones), do: @teens_map["1" <> ones]
  defp handle_under_one_hundred(tens, ones) do
      format_number_text(@tens[tens]) <>
      @singles[ones]
  end

  #---------------------------------------------------------------------------
  # format_number_text/2
  # Adds spacing
  #---------------------------------------------------------------------------
  defp format_number_text(""), do: ""
  defp format_number_text(number_text), do: number_text <> " "

 end





