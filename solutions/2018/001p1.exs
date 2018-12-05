"../../input/2018/1.txt"
|> File.read!()
|> String.split()
|> Enum.map(fn x -> Integer.parse(x) |> elem(0) end)
|> Enum.reduce(0, fn(x, acc) -> acc + x end)
|> IO.puts()
