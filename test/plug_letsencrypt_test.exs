defmodule PlugLetsEncryptTest do
  use ExUnit.Case, async: true
  use Plug.Test

  defmodule TestApp do
    use Plug.Router

    plug PlugLetsEncrypt, response: "foo.bar"
    plug :match
    plug :dispatch

    get "/foo" do
      conn |> send_resp(200, "Hello")
    end

    match _ do
      conn |> send_resp(404, "Not found")
    end
  end

  test "responds with response if GET path matches" do
    conn = :get
    |> conn("http://www.example.com/.well-known/acme-challenge/foo")
    |> TestApp.call(TestApp.init([]))

    assert conn.status == 200
    assert conn.resp_body == "foo.bar"
  end

  test "responds with regular response if POST path matches" do
    conn = :post
    |> conn("http://www.example.com/.well-known/acme-challenge/foo")
    |> TestApp.call(TestApp.init([]))

    assert conn.status == 404
    assert conn.resp_body == "Not found"
  end

  test "responds with regular response if path does not match" do
    conn = :get
    |> conn("http://www.example.com/foo")
    |> TestApp.call(TestApp.init([]))

    assert conn.status == 200
    assert conn.resp_body == "Hello"
  end
end
