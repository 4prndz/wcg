import simplifile
import gleam/io
import argv
import utility/output
import gleam/string
import gleam/list

pub fn main() {
  case argv.load().arguments {
    ["-c", file] -> read_file_byte(file)
    ["-l", file] -> read_file_lines(file)
    ["-w", file] -> read_file_words(file)
    _ -> io.println("wcg: not found args.")
  }
}

pub fn read_file_byte(file: String) -> Nil {
  case simplifile.read(file) {
    Ok(content) -> {
      string.byte_size(content)
      |> output.build("bytes", file)
    }
    Error(_) -> {
      io.println("wcg: " <> file <> ": No such file or directory")
    }
  }
}

pub fn read_file_lines(file: String) -> Nil {
  case simplifile.read(file) {
    Ok(content) -> {
      {
        string.split(content, "\n")
        |> list.length()
      }
      - 1
      |> output.build("lines", file)
    }
    Error(_) -> {
      io.println("wcg: " <> file <> ": No such file or directory")
    }
  }
}

pub fn read_file_words(file: String) -> Nil {
  case simplifile.read(file) {
    Ok(content) -> {
      {
        string.replace(content, "\n", " ")
        |> string.split(" ")
        |> list.filter(fn(x) { x != "" && x != " " })
        |> list.length()
      }
      |> output.build("words", file)
    }
    Error(_) -> {
      io.println("wcg: " <> file <> ": No such file or directory")
    }
  }
}
