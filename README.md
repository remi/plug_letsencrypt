PlugLetsEncrypt
=================

[![Travis](https://img.shields.io/travis/remiprev/plug_letsencrypt.svg?style=flat-square)](https://travis-ci.org/remiprev/plug_letsencrypt)
[![Hex.pm](https://img.shields.io/hexpm/v/plug_letsencrypt.svg?style=flat-square)](https://hex.pm/packages/plug_letsencrypt)

`PlugLetsEncrypt` responds to Let’s Encrypt domain verification requests.

Installation
------------

Add `plug_letsencrypt` to the `deps` function in your project's `mix.exs` file:

```elixir
defp deps do
  [
    …,
    {:plug_letsencrypt, "~> 0.2"}
  ]
end
```

Then run `mix do deps.get, deps.compile` inside your project's directory.

Usage
-----

`PlugLetsEncrypt` can be used just as any other plugs. Add `PlugLetsEncrypt`
before all of the other “route” plugs.

```elixir
defmodule Endpoint do
  plug PlugLetsEncrypt, response: System.get_env("LETSENCRYPT_RESPONSE")

  # …

  plug Router
end
```

The result:

```bash
$ curl -XGET "http://localhost:4000/.well-known/acme-challenge/key"
key.secret

$ curl -XGET "http://localhost:4000/.well-known/acme-challenge/anything"
```

License
-------

`PlugLetsEncrypt` is © 2017 [Rémi Prévost](http://exomel.com) and may be
freely distributed under the [MIT license](https://github.com/remiprev/plug_letsencrypt/blob/master/LICENSE.md). See the
`LICENSE.md` file for more information.
