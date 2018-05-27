defmodule CpuClient do

  defdelegate start(), to: CpuClient.Simulate

end
