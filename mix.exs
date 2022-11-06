defmodule MixBlake3.Project do
  use Mix.Project

  def project do
    [
      app: :blake3,
      version: "0.4.1",
      elixir: "~> 1.14",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      compilers: [:rustler] ++ Mix.compilers(),
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  def application do
    []
  end

  defp package() do
    [
      description: "Elixir binding for the Rust Blake3 implementation",
      files: ["lib", "native", ".formatter.exs", "README*", "LICENSE*", "mix.exs"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/Thomas-Jean/blake3"}
    ]
  end

  defp deps do
    [
      {:rustler, "~> 0.26.0"},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      extras: ["README.md"],
      main: "readme",
      source_url: "https://github.com/Thomas-Jean/blake3"
    ]
  end

  def config_features() do
    simd =
      case Application.get_env(:blake3, :simd_mode) || System.get_env("BLAKE3_SIMD_MODE") do
        "c_neon" -> "neon"
        :c_neon -> "neon"
        "neon" -> "neon"
        :neon -> "neon"
        _ -> nil
      end

    rayon = if !is_nil(Application.get_env(:blake3, :rayon) || System.get_env("BLAKE3_RAYON")) do
      "rayon"
    else
      nil
    end

    Enum.filter([simd, rayon], fn x -> x !== nil end)
  end
end
