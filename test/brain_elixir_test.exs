defmodule BrainElixir.PerceptronTest do
  use ExUnit.Case

  test "adding charge adds to the existing charge" do
    {:ok, pid1} = BrainElixir.Perceptron.start_perceptron()
    {:ok, pid2} = BrainElixir.Perceptron.start_perceptron()
    {:ok, pid3} = BrainElixir.Perceptron.start_perceptron()

    send pid1, {:add_charge, pid2, 2}
    send pid1, {:add_charge, pid3, 3}
    send pid1, {:get_charge, self}
    assert_receive 5

  end

  test "charge will be removed after some time" do
    {:ok, pid1} = BrainElixir.Perceptron.start_perceptron()

    send pid1, {:add_charge, self, 2}
    send pid1, {:get_charge, self}
    assert_receive 2

    :timer.sleep(20)
    send pid1, {:get_charge, self}
    assert_receive 0
  end

  test "should fire messages to connected synapses" do
    {:ok, pid1} = BrainElixir.Perceptron.start_perceptron(%{self => 0.1})
    send pid1, {:add_charge, self, 0.3}
    assert_receive {:add_charge, pid1, charge}
  end
end
