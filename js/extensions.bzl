"Module extensions for use with bzlmod"

load("@aspect_bazel_lib//lib:repositories.bzl", "DEFAULT_YQ_VERSION", "register_yq_toolchains")

def _toolchain_extension(module_ctx):
    register_yq_toolchains(version = DEFAULT_YQ_VERSION)

ext = module_extension(
    implementation = _toolchain_extension,
)
