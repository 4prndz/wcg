import simplifile
import gleam/io
import argv
import utility/output
import gleam/string
import gleam/list
import gleam/result

pub fn main() {
  case argv.load().arguments {
    ["-c", file] -> {
      handle_request(read_file_bytes(file), "bytes", file)
    }
    ["-l", file] -> {
      handle_request(read_file_lines(file), "lines", file)
    }
    ["-w", file] -> {
      handle_request(read_file_words(file), "words", file)
    }
    ["-m", file] -> {
      handle_request(read_file_chars(file), "chars", file)
    }
    [file] -> {
      read_file(file)
    }
    _ -> io.println("wcg: not found args.")
  }
}

pub fn handle_request(
  result: Result(Int, String),
  unit: String,
  file: String,
) -> Nil {
  case result {
    Ok(x) -> output.build(x, unit, file)
    Error(_) -> io.println("wcg: " <> file <> ": File or Directory not found!")
  }
}

pub fn read_file_bytes(file: String) -> Result(Int, String) {
  case simplifile.read(file) {
    Ok(content) -> {
      string.byte_size(content)
      |> Ok()
    }
    Error(_) -> {
      Error("File not Found")
    }
  }
}

pub fn read_file_lines(file: String) -> Result(Int, String) {
  case simplifile.read(file) {
    Ok(content) -> {
      {
        string.split(content, "\n")
        |> list.length()
      }
      - 1
      |> Ok()
    }
    Error(_) -> {
      Error("")
    }
  }
}

pub fn read_file_words(file: String) -> Result(Int, String) {
  case simplifile.read(file) {
    Ok(content) -> {
      {
        string.replace(content, "\n", " ")
        |> string.split(" ")
        |> list.filter(fn(x) { x != "" && x != " " })
        |> list.length()
      }
      |> Ok()
    }
    Error(_) -> {
      Error("")
    }
  }
}

pub fn read_file_chars(file: String) -> Result(Int, String) {
  case simplifile.read(file) {
    Ok(content) -> {
      {
        content
        |> string.split("")
        |> list.length()
      }
      |> Ok()
    }
    Error(_) -> {
      Error("")
    }
  }
}

pub fn read_file(file: String) -> Nil {
  case simplifile.read(file) {
    Ok(_) ->
      output.default_build(
        result.unwrap(read_file_bytes(file), 1),
        result.unwrap(read_file_lines(file), 1),
        result.unwrap(read_file_words(file), 1),
        file,
      )
    Error(_) -> io.println("File not Found")
  }
}
