# ExChequer

A simple module for writing numbers into words as can be seen on checks. 

## Instructions
Start an iex session and pass a number, *e.g. 1234.5* or *"1234.5"*

## Examples

```$ iex  
Erlang/OTP 21 [erts-10.2.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Interactive Elixir (1.7.4) - press Ctrl+C to exit (type h() ENTER for help)  
iex(1)> c"ex_chequer.exs"
[ExChequer]  
iex(2)>  ExChequer.convert_amount_to_text(12345678.90)
"TWELVE MILLION THREE HUNDRED FORTY FIVE THOUSAND SIX HUNDRED SEVENTY EIGHT AND 9/100"
iex(3)> ExChequer.convert_amount_to_text("42")       
"FORTY TWO"
iex(4)> ExChequer.convert_amount_to_text(80808)
"EIGHTY THOUSAND EIGHT HUNDRED EIGHT"

```