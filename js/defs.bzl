"""Rules for running JavaScript programs"""

load(
    "//js/private:js_binary.bzl",
    _js_binary = "js_binary",
    _js_binary_lib = "js_binary_lib",
    _js_test = "js_test",
)
load(
    "//js/private:js_library.bzl",
    _js_library = "js_library",
    _js_library_lib = "js_library_lib",
)
load(
    "//js/private:js_run_binary.bzl",
    _js_run_binary = "js_run_binary",
)

def js_binary(**kwargs):
    _js_binary(
        enable_runfiles = select({
            "@aspect_rules_js//js/private:enable_runfiles": True,
            "//conditions:default": False,
        }),
        **kwargs
    )

def js_test(**kwargs):
    _js_test(
        enable_runfiles = select({
            "@aspect_rules_js//js/private:enable_runfiles": True,
            "//conditions:default": False,
        }),
        **kwargs
    )

js_library = _js_library
js_run_binary = _js_run_binary

# export the starlark libraries as a public API
js_binary_lib = _js_binary_lib
js_library_lib = _js_library_lib
