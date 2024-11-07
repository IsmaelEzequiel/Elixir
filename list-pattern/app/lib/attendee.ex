defmodule Attendee do
  defstruct name: "", paid: false, under_age: true

  def may_attendee(attendee = %Attendee{}) do
    attendee.name && attendee.under_age
  end

  def print(%Attendee{name: name}) when name != "" do
    IO.puts "Olá, #{name}"
  end

  def print(%Attendee{}) do
    IO.puts "xiii, faltando nome"
  end
end
