defmodule Secrets do
  def secret_add(secret) do
    &(&1 + secret)
  end

  def secret_subtract(secret) do
    &(&1 - secret)
  end

  def secret_multiply(secret) do
    &(&1 * secret)
  end

  def secret_divide(secret) do
    fn param ->
      trunc(param / secret)
    end
  end

  def secret_and(secret) do
    fn param ->
      Bitwise.band(param, secret)
    end
  end

  def secret_xor(secret) do
    fn param ->
      Bitwise.bxor(param, secret)
    end
  end

  def secret_combine(secret_function1, secret_function2) do
    fn param ->
      result = secret_function1.(param)
      secret_function2.(result)
    end
  end
end
