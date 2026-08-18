# fubá

uma coelhinha virtual em elixir. tamagotchi de terminal promovido a web, camada por camada.

regra de ouro: **coração limpo, casquinha na borda**. a lógica mora em módulos puros e testados. a web é só casquinha, intercambiável, nunca toca o coração.

quatro medidores de 0 a 5: `biscoito`, `cafeina`, `carinho`, `energia`. quatro ações: dar biscoito, dar café, fazer cafuné, dar espaço. humor calculado dos medidores, nunca guardado. desregulada, só espaço ajuda.

```sh
mix test
iex -S mix
```

```elixir
iex> fuba = %Fuba.Coelhinha{}
iex> fuba = Fuba.Cuidado.dar_biscoito(fuba)
iex> Fuba.Cuidado.humor(fuba)
:feliz
```
