# Downstream

**Downstream** is a thin wrapper around [hackney] that turns the response body
of an HTTP/S request into an Elixir stream.

It also provides a convenience wrapper `Downstream.download/2` that will take
care of streaming the data directly to a file at the provided output path.

Several more functions are available as well:

- `download/3` allows you to provide a callback that will fire every chunk with
  metadata for the purposes of doing things like showing a progress indicator,
  but still handles streaming of the data directly to a file like `download/2`.

- `stream/3` returns an Elixir stream of chunks containing iodata that can be
  piped directly into a `File.stream!` or other `Collectable`. If the
  `metadata: true` option is provided, then these chunks will instead be a
  `Downstream.Chunk` struct containing keys `:data` and `:metadata` which may
  be transformed for more advanced behavior.

## Installation

```elixir
def deps do
  [
    {:downstream, "~> 0.1.0"}
  ]
end
```

## Implementation

**Downstream** operates by transforming the output of repeated calls to
`:hackney.stream_body/1` into an Elixir stream using `Stream.resource/3`, and
packaging this with the the status code and headers returned by the initial
call to `:hackney.get/3`, along with some useful metadata like total file
length, length downloaded, and length remaining.


[Libgit2]: https://github.com/bcksl/libgit2_ex
[hackney]: https://github.com/benoitc/hackney

