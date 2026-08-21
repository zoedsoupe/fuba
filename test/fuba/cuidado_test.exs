defmodule Fuba.CuidadoTest do
  use ExUnit.Case

  alias Fuba.{Coelhinha, Cuidado}

  describe "humor/1" do
    test "desregulada com dois ou mais medidores em 0" do
      assert Cuidado.humor(%Coelhinha{biscoito: 0, cafeina: 0}) == :desregulada
    end

    test "go_queen com todos os medidores >= 4" do
      assert Cuidado.humor(%Coelhinha{biscoito: 4, cafeina: 5, carinho: 4, energia: 5}) ==
               :go_queen
    end

    test "chatinha com um medidor em 0" do
      assert Cuidado.humor(%Coelhinha{biscoito: 0}) == :chatinha
    end

    test "feliz no resto" do
      assert Cuidado.humor(%Coelhinha{}) == :feliz
    end
  end

  describe "aplicar/2" do
    test "desregulada ignora cafuné" do
      fuba = %Coelhinha{biscoito: 0, cafeina: 0}
      assert Cuidado.aplicar(fuba, :cafune) == fuba
    end

    test "desregulada aceita espaço" do
      fuba = %Coelhinha{biscoito: 0, cafeina: 0, energia: 1}
      assert Cuidado.aplicar(fuba, :espaco).energia == 3
    end
  end

  describe "limita/1" do
    test "não passa de 5 nem desce de 0" do
      assert Cuidado.limita(7) == 5
      assert Cuidado.limita(-2) == 0
      assert Cuidado.limita(3) == 3
    end
  end

  describe "tempo_passa/1" do
    test "nunca negativa" do
      fuba = %Coelhinha{biscoito: 0, cafeina: 0, carinho: 0, energia: 0}
      assert Cuidado.tempo_passa(fuba) == fuba
    end
  end
end
