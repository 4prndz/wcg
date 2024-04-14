import gleam/int
import gleam/string
import gleam/io

pub fn build(count: Int, unit: String, file_name: String) -> Nil {
  { int.to_string(count) <> " " <> unit <> " " <> file_name }
  |> io.println()
}

pub fn default_build(
  count_bytes: Int,
  count_lines: Int,
  count_words: Int,
  file_name: String,
) -> Nil {
  let output =
    [
      int.to_string(count_bytes),
      " bytes ",
      int.to_string(count_lines),
      " lines ",
      int.to_string(count_words),
      " words ",
    ]
    |> string.concat()

  io.println(output <> file_name)
}
