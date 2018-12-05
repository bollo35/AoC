defmodule Two do
  def letter_counts(c_list) do
    count_map = 
      Enum.reduce(c_list, %{}, fn x, acc ->
        Map.update(acc, x, 1, &(&1 + 1))
      end)
    {c_list, count_map}
  end
  
  def exact_count?(count_map, count) do
    count_map
    |> Map.values
    |> Enum.any?(&(&1 == count))
  end

  # determine the number of different characters
  # NB: assumes that a and b are of equal length
  def diff(a, b) do
    Enum.reduce(Enum.zip(a, b), 0, fn {a,b}, acc -> 
      if a != b, do: acc+1, else: acc
    end)
  end

  # assume there are only two nearly matching box IDs
  def find_da_boxes([h | t]) do
    matches = Enum.filter(t, fn x -> diff(h, x) == 1 end)
    if Enum.empty?(matches), do: find_da_boxes(t), else: {h, hd(matches)}
  end
end

count_maps =
  "../../input/2018/2.txt"
  |> File.read!()
  |> String.split()
  |> Enum.map(&to_charlist/1)
  |> Enum.map(&Two.letter_counts/1)

twos = 
  count_maps
  |> Enum.count(&(Two.exact_count?( elem(&1, 1) , 2)))

threes = 
  count_maps
  |> Enum.count(&(Two.exact_count?( elem(&1, 1) , 3)))

IO.puts("Checksum: #{twos*threes}")

{id1, id2 } = 
  count_maps
  |> Enum.filter(fn {_, m} -> Two.exact_count?(m, 2) || Two.exact_count?(m, 3) end)
  |> Enum.map(fn {s,_} -> s end)
  |> Two.find_da_boxes()

Enum.zip(id1, id2)
|> Enum.reject(fn {a,b} -> a != b end)
|> Enum.map(fn {a,a} -> a end)
|> IO.puts()
