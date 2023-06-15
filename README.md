# Downstream

**Downstream** is a thin wrapper around [hackney] initially created to enable
the simple use-case of efficiently downloading objects over HTTP/S straight to
disk.

If that's what you'd like to do as well, use the convenient `download/2` which
will deal with everything. After a while, there will be a file at the path
specified and memory usage will not have exploded.

Several more functions are in fact provided:

- `download/3` allows you to provide a callback that will fire every chunk with
  metadata in case you'd like to do something like make a progress indicator,
  but still don't care about the actual data.

- `stream/2` will give you a stream of iodata chunks that can be piped directly into a `File.stream!` or anything 

- `stream_extra`, despite being named "extra" is the function all the rest of them are based on, which produces chunks that include not only the bit of data being returned but also a variety of metadata. `stream/1` strips this out for you.

It does this by turning `:hackney.stream_body/1` into a proper Elixir stream, w
provided URL directly to a file path.

If you would like to stream the data to something else, you can ask it to give you
back a stream with or without metadata.

That what **Downstream** does, no more and no less.

## Installation

```elixir
def deps do
  [
    {:downstream, "~> 0.1.0"}
  ]
end
```

[Libgit2]: https://github.com/bcksl/libgit2_ex
[hackney]: https://github.com/benoitc/hackney
