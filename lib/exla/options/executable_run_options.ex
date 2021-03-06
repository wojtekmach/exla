defmodule Exla.Options.ExecutableRunOptions do
  defstruct allocator: nil,
            device: {:host, -1},
            stream: nil,
            intra_op_thread_pool: nil,
            execution_profile: nil,
            rng_seed: nil,
            launch_id: 0,
            host_to_device_stream: nil,
            then_execute_function: nil,
            run_id: nil,
            gpu_executable_run_options: nil
end
