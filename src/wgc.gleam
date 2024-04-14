import simplifile
import gleam/io
import argv
import gleam/bit_array
import utility/output

pub fn main() {
  case argv.load().arguments {
    ["-c", file] -> read_file_byte(file)
    _ -> io.println("wcg: not found args.")
  }
}

pub fn read_file_byte(file: String) -> Nil {
  case simplifile.read_bits(file) {
    Ok(file_bits) -> {
      bit_array.byte_size(file_bits)
      |> output.build("bytes", file)
    }
    Error(_) -> {
      io.println("file not found")
    }
  }
}
