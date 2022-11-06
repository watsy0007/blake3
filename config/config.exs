import Config
# config :blake3, simd_mode: "std"
# config :blake3, rayon: :false
config :blake3, Blake3.Native,
  mode: :release,
  features: MixBlake3.Project.config_features()
