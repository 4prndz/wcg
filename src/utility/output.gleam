import gleam/int.{to_string}
import gleam/io

pub fn build(size: Int, unit: String, file_name: String) -> Nil {
  { int.to_string(size) <> " " <> unit <> " " <> file_name }
  |> io.println()
}
