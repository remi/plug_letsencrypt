defmodule PlugLetsEncrypt.Mixfile do
  use Mix.Project

  # Constants
  @version "0.1.0"

  def project do
    [app: :plug_letsencrypt,
     version: @version,
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package(),
    dialyzer: dialyzer(),
     name: "Plug Let's Encrypt",
     source_url: "https://github.com/remiprev/plug_letsencrypt",
     homepage_url: "https://github.com/remiprev/plug_letsencrypt",
     description: "PlugLetsEncrypt responds to Let’s Encrypt domain verification requests.",
     docs: [extras: ["README.md"], main: "readme", source_ref: "v#{@version}", source_url: "https://github.com/remiprev/plug_letsencrypt"]]
  end

  def application do
    [applications: []]
  end

  def dialyzer do
    [plt_add_apps: [:plug],
     plt_file: ".plts/.local.plt",
     plt_core_path: ".plts"]
  end

  defp deps do
    [
      {:plug, "~> 1.0"},
      {:credo, "~> 0.6", only: :dev},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev},
      {:dialyxir, "~> 0.4", only: :dev}
    ]
  end

  defp package do
    %{
      maintainers: ["Rémi Prévost"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/remiprev/plug_letsencrypt"
      }
    }
  end
end
