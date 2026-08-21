defmodule Fuba.Coelhinha do
  defstruct nome: "Fubá", biscoito: 3, cafeina: 3, carinho: 3, energia: 3

  @type t :: %__MODULE__{
          nome: String.t(),
          biscoito: 0..5,
          cafeina: 0..5,
          carinho: 0..5,
          energia: 0..5
        }
end
