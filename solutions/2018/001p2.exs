defmodule One2 do
  def reducer(x, {freqs, curr_freq}) do
    f = curr_freq + x
    if MapSet.member?(freqs, f) do
      {:halt, f}
    else
      {:cont, {MapSet.put(freqs, f), f}}
    end
  end

  def find_repeat(nums, seed = {_, _}) do
    res = Enum.reduce_while(nums, seed, &One2.reducer/2)
    find_repeat(nums, res)
  end

  def find_repeat(_nums, repeat), do: repeat
end

"../../input/2018/1.txt"
|> File.read!()
|> String.split()
|> Enum.map(fn x -> Integer.parse(x) |> elem(0) end)
|> One2.find_repeat({MapSet.new([0]), 0})
|> IO.puts()
