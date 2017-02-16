defmodule PlugLetsEncrypt do
  @moduledoc """
  This plug intercepts requests made by Let’s Encrypt to
  prove ownership of a domain.

  ## Elixir
  ```
  # LETSENCRYPT_RESPONSE=key.secret
  plug PlugLetsEncrypt, response: System.get_env("LETSENCRYPT_RESPONSE")
  ```

  ## Request
  ```
  $ curl "/.well-known/acme-challenge/key"
  key.secret
  ```
  """

  # Imports
  import Plug.Conn

  # Aliases
  alias Plug.Conn

  # Behaviours
  @behaviour Plug

  # Types
  @type opts :: binary | tuple | atom | integer | float | [opts] | %{opts => opts}

  # Constants
  @path "/.well-known/acme-challenge/"
  @method "GET"
  @success_code 200

  @doc """
  Initialize this plug.
  """
  @spec init(opts) :: opts
  def init(opts) do
    [key, secret] = opts
    |> Keyword.fetch!(:response)
    |> String.split(".")

    Enum.zip([:key, :secret], [key, secret])
  end

  @doc """
  Call the plug.
  """
  @spec call(%Conn{}, opts) :: %Conn{}
  def call(conn = %Conn{request_path: request_path, method: method}, key: key, secret: secret)
    when method == @method and request_path == @path <> key do
    conn
    |> send_resp(@success_code, "#{key}.#{secret}")
    |> halt
  end
  def call(conn, _), do: conn
end
