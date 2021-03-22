defmodule MyProj do
  use Rustler, otp_app: :my_proj, crate: "my_proj"

  def add(_a, _b) do
    :erlang.nif_error(:nif_not_loaded)
  end
end
