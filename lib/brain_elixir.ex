defmodule BrainElixir do
end


# Based on https://www.youtube.com/watch?v=q0pm3BrIUFo
# and https://www4.rgu.ac.uk/files/chapter3%20-%20bp.pdf

defmodule BrainElixir.Perceptron do
  # A perceptron knows who it is connected to and by what weights
  # it does not know who connects to it and by what weights
  # But if it recieves a message on

  def start_perceptron(synapses \\ %{}) do
    Task.start_link(fn -> perceptron_receive_message(synapses, %{}) end)
  end

  defp perceptron_receive_message(synapses, charges) do
    activation_energy = 0.01
    active_time = 10
    receive do
      {:add_charge, from, charge} ->
        IO.puts "add_charge to #{inspect self()}"

        #filter_charges
        new_charges = Map.put(charges, from, charge)
        #increase charge

        #fire_charge?

        #fire

        perceptron_receive_message(synapses, new_charges)
      {:get_charge, from} ->
        charge = current_charge(charges)
        IO.puts "get_charge to #{inspect self()}"
        send from, charge
        perceptron_receive_message(synapses, charges)
    end
  end

  def current_charge(charges) do
    Enum.reduce(Map.values(charges) , 0 , fn x,a -> x+a end)
  end

  # def receive_charge(from, charge) do
  #   IO.puts "P #{@uuid} receive_charge #{charge} from #{from}"
  #   time = new Date().getTime()
  #   @increase_charge(from, charge)
  #   current_charge = @current_charge()
  #   for to, weight of @synapses
  #     charge_to_send = @calculate_charge(current_charge, weight)
  #     if Math.abs(charge_to_send) > @activation_energy
  #       @brain.send_charge(@uuid, to, charge_to_send)

  # end

  # def increase_charge(from, value) do
  #   #this is a simple little function that removes the charge
  #   #TODO make this a smooth function so charge decreases slowly

  #   @current_chargers[from] = value
  #   timer = bb.delay(@active_time)
  #   timer.cancellable()
  #   timer.catch(bb.CancellationError, (e) ->
  #     IO.puts e
  #   )

  #   if @timers[from]
  #     @timers[from].cancel()

  #   @timers[from] = timer

  #   timer.then( =>
  #     delete @current_chargers[from]
  #     delete @timers[from]
  #     @current_charge()
  #   )
  #   .catch(bb.CancellationError, (e) ->
  #     IO.puts e
  #   )

  # end

  # def calculate_charge(value, weight) do
  #   return value * weight
  #   # #weight * sigmoid function weight * (1 / (1+ Math.pow(Math.E, - value)))
  # end

  # ####################################
  # ###       Backpropagation        ###
  # ####################################

  # def receive_backpropagation(from, error, charge) do
  #   IO.puts "P #{@uuid} receive_backpropagation of error #{error} and charge #{charge} from #{from}"
  #   error_a = charge * (1 - charge) * error * weights[x]

  #   @brain.send_backpropagation(@uuid, to, error, sent_value)

  # end

  # def error_a(output_a) do
  #   total_error = 0
  #   for w_ax in weights
  #     total_error = total_error + (error_x * w_ax)

  #   output * (1 - output) * total_error

  # end

  # def new_weight_ab(current_weight_ab, error_b, output_a) do
  #   current_weight_ab + (error_b * output_a)

  # end

end


