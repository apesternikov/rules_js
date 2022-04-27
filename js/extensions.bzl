"""Adapt repository rules in npm_import.bzl to be called from MODULE.bazel

See https://bazel.build/docs/bzlmod#extension-definition
"""

load("//js/private:npm_import.bzl", _npm_import = "npm_import")
load("//js/private:translate_pnpm_lock.bzl", _translate_pnpm_lock = "translate_pnpm_lock")
load("//js:npm_import.bzl", "npm_import", "translate_pnpm_lock")

def _extension_impl(module_ctx):
    for mod in module_ctx.modules:
        for lock in mod.tags.pnpm_lock:
            translate_pnpm_lock(**{k: getattr(lock, k) for k in dir(lock)})
        for pkg in mod.tags.package:
            npm_import(**{k: getattr(pkg, k) for k in dir(pkg)})

npm = module_extension(
    implementation = _extension_impl,
    tag_classes = {
        "pnpm_lock": tag_class(attrs = dict({"name": attr.string()}, **_translate_pnpm_lock.attrs)),
        "package": tag_class(attrs = dict({"name": attr.string()}, **_npm_import.attrs)),
    },
)
