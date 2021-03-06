load("@org_tensorflow//tensorflow/core/platform/default:cuda_build_defs.bzl", "if_cuda_is_configured",)

package(default_visibility=["//visibility:private"])

cc_library(
  name = "exla_allocator",
  srcs = ["exla_allocator.cc"],
  hdrs = ["exla_allocator.h"],
  deps = [
    "@org_tensorflow//tensorflow/stream_executor:stream_executor_headers",
    "@org_tensorflow//tensorflow/compiler/xla:statusor",
  ],
)

# TODO: I don't like the NIF dependency, try and work around it
cc_library(
  name = "exla_macros",
  hdrs = ["exla_macros.h"],
  deps = [
    ":exla_nif_util"
  ]
)

cc_library(
  name = "exla_nif_util",
  srcs = ["exla_nif_util.cc"],
  hdrs = ["exla_nif_util.h"] + glob(["erts/**/*.h"]),
  deps = [
    ":exla_allocator",
    "@com_google_absl//absl/types:span",
    "@org_tensorflow//tensorflow/stream_executor:stream_executor_headers",
    "@org_tensorflow//tensorflow/compiler/xla:executable_run_options",
    "@org_tensorflow//tensorflow/compiler/xla/client:client_library",
    "@org_tensorflow//tensorflow/compiler/xla/client:executable_build_options"
  ],
)

# This target links in both GPU/CPU Device
cc_binary(
  name = "libexla_gpu.so",
  srcs = ["exla.cc"],
  deps = if_cuda_is_configured([
    "@org_tensorflow//tensorflow/compiler/jit:xla_gpu_jit",
    ]) + [
    ":exla_allocator",
    ":exla_nif_util",
    ":exla_macros",
    "@org_tensorflow//tensorflow/compiler/xla/client:client",
    "@org_tensorflow//tensorflow/compiler/xla/client:client_library",
    "@org_tensorflow//tensorflow/compiler/xla/client:xla_builder",
    "@org_tensorflow//tensorflow/compiler/xla/client:xla_computation",
    "@org_tensorflow//tensorflow/compiler/jit:xla_cpu_jit",
  ],
  linkopts = ["-shared"],
  linkshared = 1,
)

# This target links in just CPU device
cc_binary(
  name = "libexla_cpu.so",
  srcs = ["exla.cc"],
  deps = [
    ":exla_allocator",
    ":exla_nif_util",
    ":exla_macros",
    "@org_tensorflow//tensorflow/compiler/xla/client:client",
    "@org_tensorflow//tensorflow/compiler/xla/client:client_library",
    "@org_tensorflow//tensorflow/compiler/xla/client:xla_builder",
    "@org_tensorflow//tensorflow/compiler/xla/client:xla_computation",
    "@org_tensorflow//tensorflow/compiler/jit:xla_cpu_jit",
  ],
  linkopts = ["-shared"],
  linkshared = 1,
)
