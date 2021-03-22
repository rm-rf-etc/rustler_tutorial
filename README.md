# Example Rust NIF with Rustler

Sharing this example to help others. I'm using a 2020 MacBook Air with the M1 CPU.

Out of the box, rustler would not build for me. Multiple small details tripped me
up, what you need to be aware of are:
- You need `:rustler_crates` and `:compilers` in your `mix.exs` file.
- The names you enter for module and library when doing `mix rustler.new` need to
match the names in your `mix.exs` and where you call `use Rustler` (details below).
- You have to provide a dummy override for your functions (details below).

# Complete Setup Steps

Erring on the side of completeness so hopefully all followers of this guide will
have success.

```bash
mix new my_proj
cd my_proj

# add {:rustler, "~> 0.22-rc"} to mix.exs deps list
mix deps.get

# at the prompt use MyProj for module name and my_proj for library name
mix rustler.new
```

Now update your project configuration in `mix.exs`, adding `:compilers` and
`:rustler_crates` so that it matches the following:

```elixir
  def project do
    [
      app: :my_proj,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: [my_proj: []],
      deps: deps()
    ]
  end
```

Now update `my_proj.ex` to contain the following:

```elixir
defmodule MyProj do
  use Rustler, otp_app: :my_proj, crate: "my_proj"

  def add(_a, _b) do
    :erlang.nif_error(:nif_not_loaded)
  end
end
```

Now build and run:
```bash
mix compile
iex -S mix

iex(1)> MyProj.add(1, 2)
# 3
```

More info here: https://hexdocs.pm/rustler/basics.html#crate-configuration

Based on these tutorials:
- https://medium.com/@jacob.lerche/writing-rust-nifs-for-your-elixir-code-with-the-rustler-package-d884a7c0dbe3
- https://simplabs.com/blog/2020/06/25/writing-rust-nifs-for-elixir-with-rustler/
