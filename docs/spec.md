# Spec — Série "Fubá Web" + Fubá aparada

> Documento de planejamento. Nada aqui é texto de blog — é a estrutura que os posts e o código vão seguir.

---

## Parte 1 — Spec da série

### Tese

Uma pergunta inocente ("quero fazer uma coisa com elixir, mas eu preciso de uma tela bonitinha") desempacota a stack web inteira. Cada post responde **uma** pergunta real de quem tá aprendendo, constrói **uma** camada, e termina com o gancho que motiva a próxima. Nenhuma peça entra antes da dor que ela resolve.

### Método

- Bancada, não apostila: o post dá o problema e a validação; o leitor tenta antes de ler a solução.
- Toda parte termina com um critério de "fechou?" verificável no terminal/navegador.
- A regra de ouro — **coração limpo, casquinha na borda** — é nomeada no post 2 e cobrada em todos os seguintes.
- Duas provas públicas da regra: o diff vazio do `Cuidado` no post 5 (SSR) e no post 7 (LiveView).

### Público e pré-requisitos

- Público: quem sabe HTML+CSS, terminou (ou quase) os exlings, nunca tocou em web backend.
- Pré-requisitos declarados no post 1: exlings feitos, HTML+CSS, terminal básico, Elixir 1.18+ instalado.
- exlings aparece como camada de treino: cada post pode apontar o conjunto de exercícios correspondente.

### Posts

#### 1. "Amor, como que faz uma tela bonitinha?" — manifesto

- **Pergunta-guia:** a mensagem original, verbatim.
- **Conteúdo:** o iceberg da pergunta; mapa da série; método; por que mínimo; pré-requisitos.
- **Constrói:** nada (ou só `elixir --version`).
- **Validação:** leitor sabe dizer o que a série vai construir e por que nessa ordem.
- **Gancho:** "antes de tela, a Fubá precisa existir."

#### 2. O coração da Fubá

- **Pergunta-guia:** "por onde começo?"
- **Conceitos:** struct, pattern matching em cláusulas, `cond`, imutabilidade (recap rápido — exlings já cobriu), função pura vs. efeito colateral.
- **Constrói:** `mix new fuba` + os três módulos do coração (ver Parte 2) + um teste.
- **Deps novas:** nenhuma.
- **Validação:** `mix test` verde; `iex -S mix` responde os quatro humores.
- **Gancho:** "ela existe, mas ninguém vê."

#### 3. HTTP na unha

- **Pergunta-guia:** "o que é um servidor?"
- **Conceitos:** cliente/servidor, requisição/resposta, método + path + status, porta.
- **Constrói:** um módulo `Plug` escrito na mão (hello world); `curl` como "voz" da Fubá.
- **Deps novas:** `plug_cowboy` (única dep até aqui).
- **Validação:** `curl` e navegador veem a mesma resposta.
- **Gancho:** "texto sem graça. cadê a tela bonitinha?"

#### 4. A página morta

- **Pergunta-guia:** "por que o botão não faz nada?"
- **Conceitos:** arquivos estáticos, o que é (e o que não é) backend.
- **Constrói:** `Plug.Static` servindo a página morta (arquivo único, já pronto).
- **Deps novas:** nenhuma.
- **Validação:** página linda no ar, botões inertes — e isso é o problema.
- **Gancho:** "e se o HTML fosse gerado a partir dela?"

#### 5. HTML é uma função do estado

- **Pergunta-guia:** "o que é um template?"
- **Conceitos:** SSR desmistificado, EEx, `Plug.Router`; um `Agent` como "caixinha que guarda a coelhinha" (uso pragmático, sem teoria — a teoria vem no post 8).
- **Constrói:** a página morta vira `.eex`; painel renderiza o estado real da Fubá.
- **Deps novas:** nenhuma.
- **Validação:** mexer no estado pelo `iex`, dar refresh, ver a página mudar. **Diff do `Cuidado`: zero linhas.**
- **Gancho:** "mas clicar ainda não faz nada…"

#### 6. Forms, POST e a página que pisca

- **Pergunta-guia:** "como o botão avisa o servidor?"
- **Conceitos:** form POST, redirect (padrão POST/Redirect/GET), o ciclo request/response completo.
- **Constrói:** os quatro botões funcionam de verdade.
- **Deps novas:** nenhuma.
- **Validação:** dá pra cuidar dela — mas cada clique recarrega tudo; duas abas só sincronizam no refresh. Sentir a limitação.
- **Gancho:** "e se o servidor pudesse empurrar a mudança?"

#### 7. A página ganha vida (LiveView)

- **Pergunta-guia:** "como a página atualiza sozinha?"
- **Conceitos:** flags de gerador (`mix phx.new fuba_web --no-ecto --no-mailer --no-dashboard --no-gettext --no-assets` — e a lição de *ler* o que um framework assume), websocket em um parágrafo, `mount` / `handle_event` / `assigns`.
- **Tese explícita:** `handle_event` é o `case` dentro do `loop/1` — o estado viaja em assigns como viajava na recursão; o navegador é quem digita "biscoito".
- **Constrói:** migração da Fubá pra LiveView.
- **Validação:** botões sem reload. **Diff do `Cuidado`: zero linhas, de novo.**
- **Gancho:** "abre duas abas. cada uma tem uma Fubá diferente. E ela só sente fome quando você clica."

#### 8. Ela vive sozinha

- **Pergunta-guia:** "ela fica com fome enquanto eu não tô olhando?"
- **Conceitos:** GenServer de verdade (substituindo o Agent do post 5), `Process.send_after/3` ou `:timer`, PubSub.
- **Constrói:** `tempo_passa/1` em tempo real; abas sincronizadas; a Fubá desregula sozinha.
- **Validação:** duas abas, uma Fubá; medidores caindo sem clique.
- **Payoff emocional:** a regra da desregulação finalmente dói de verdade.

#### Epílogo. O que a gente pulou (de propósito)

- Ecto/persistência, auth, pipeline de assets, deploy — um parágrafo cada, formato "quando você precisar".
- Mapa de leitura: Elixir School (pt), Exercism, docs do LiveView, *Designing Elixir Systems with OTP*.
- Exercício final tradicional: renomear a Fubá sem quebrar nada.

### Compressões possíveis

Se a série precisar encolher: 3+4 viram um post ("HTTP e a página morta"); 5+6 também ("HTML como função do estado + forms"). **Espinha irredutível:** manifesto → coração → página morta → SSR → LiveView → GenServer.

---

## Parte 2 — Spec da Fubá aparada

### Visão

Tamagotchi de terminal promovido a web. Uma coelhinha virtual com quatro medidores, quatro ações, quatro humores e uma regra emocional central: **desregulada, só espaço ajuda**. O coração é 100% puro e testado; toda casquinha (web) é intercambiável sem tocar nele.

### Requisitos funcionais

- **RF1** — A Fubá tem quatro medidores inteiros de 0 a 5: `biscoito`, `cafeina`, `carinho`, `energia`. Estado inicial: todos em 3.
- **RF2** — Quatro ações de cuidado, cada uma `coelhinha → coelhinha`:
  - `dar_biscoito/1` — biscoito +2
  - `dar_cafe/1` — cafeina +2
  - `fazer_cafune/1` — carinho +2
  - `dar_espaco/1` — energia +2, carinho −1
- **RF3** — Nenhum medidor passa de 5 nem desce de 0 (`limita/1`).
- **RF4** — Humor é **calculado** dos medidores, nunca armazenado. Ordem das regras (importa):
  1. `:desregulada` — dois ou mais medidores em 0
  2. `:go_queen` — todos os medidores ≥ 4
  3. `:chatinha` — algum medidor em 0
  4. `:feliz` — o resto
- **RF5** — `aplicar/2`: se o humor é `:desregulada` e a ação não é `:espaco`, devolve a coelhinha **inalterada**. Qualquer outro caso, aplica.
- **RF6** — `tempo_passa/1`: todos os medidores −1 (sem negativar). Só entra no post 8, disparada por timer — nunca por interação.
- **RF7** — Cada humor tem uma carinha (string, pode ser multilinha). Átomo desconhecido cai numa carinha neutra.

### API pública

```elixir
defmodule Fuba.Coelhinha do
  defstruct nome: "Fubá", biscoito: 3, cafeina: 3, carinho: 3, energia: 3
end

defmodule Fuba.Cuidado do
  @type acao :: :biscoito | :cafe | :cafune | :espaco
  @type humor :: :feliz | :chatinha | :desregulada | :go_queen

  @spec dar_biscoito(Coelhinha.t()) :: Coelhinha.t()
  @spec dar_cafe(Coelhinha.t()) :: Coelhinha.t()
  @spec fazer_cafune(Coelhinha.t()) :: Coelhinha.t()
  @spec dar_espaco(Coelhinha.t()) :: Coelhinha.t()

  @spec humor(Coelhinha.t()) :: humor()
  @spec aplicar(Coelhinha.t(), acao()) :: Coelhinha.t()
  @spec tempo_passa(Coelhinha.t()) :: Coelhinha.t()

  # pública pra ser testável no post 2; documentada como "detalhe interno"
  @spec limita(integer()) :: integer()
end

defmodule Fuba.Humor do
  @spec carinha(Cuidado.humor() | atom()) :: String.t()
end
```

### Testes mínimos (post 2)

1. `humor/1` — desregulada com dois zeros; go_queen com todos ≥ 4; chatinha com um zero; feliz no resto.
2. `aplicar/2` — desregulada ignora `:cafune` (devolve inalterada); desregulada aceita `:espaco`.
3. `limita/1` — não passa de 5 nem desce de 0.

(`tempo_passa/1` ganha teste no post 8: nunca negativa.)

### Evolução da casquinha (por post)

| Post | Casquinha | Onde mora o estado |
|------|-----------|--------------------|
| 3 | Plug na mão, resposta texto | não existe |
| 4 | `Plug.Static` + página morta | não existe (HTML fixo = `cafeina: 1`) |
| 5 | EEx + `Plug.Router` (SSR) | `Agent` |
| 6 | + form POST (PRG) | `Agent` |
| 7 | Phoenix LiveView | `assigns` (uma Fubá por aba — bug proposital) |
| 8 | + GenServer + PubSub + timer | GenServer único (uma Fubá pra todos) |

### Decisões (e por quê)

- **D1 — Coração puro, casquinha na borda.** Toda a série existe pra provar isso com dois diffs vazios (posts 5 e 7). `Cuidado` nunca importa nada de IO, HTTP ou HTML.
- **D2 — Sem persistência.** `Soninho`/JSON fica de fora; o epílogo aponta Ecto como "quando ela precisar sobreviver a restart". Manter o estado volátil também *ensina*: restart do server = Fubá nova, e isso vira gancho pro epílogo.
- **D3 — `tempo_passa/1` só com timer.** No material original o tempo passava por interação; na web isso é anti-clímax. Decaimento em tempo real é o clímax do post 8 e justifica GenServer com dor real.
- **D4 — Agent antes de GenServer.** O post 5 precisa guardar estado sem dar aula de OTP. O Agent é apresentado como "caixinha pragmática"; o post 8 substitui com teoria. Dois estágios, nenhuma mentira.
- **D5 — Uma Fubá por aba no post 7 é proposital.** O "bug" é o gancho perfeito pro PubSub do post 8: primeiro o leitor *vê* o problema, depois ganha a ferramenta.
- **D6 — `phx.new` aparado, não do zero.** Escrever LiveView na mão num Plug pelado é dor sem aprendizado proporcional. As flags viram conteúdo: o que um framework assume vs. o que você precisa.
- **D7 — `limita/1` pública.** Poderia ser privada, mas o post 2 testa ela diretamente — e "testar pela interface pública vs. expor detalhe" é uma conversa que o post pode ter em um parágrafo, consciente.
- **D8 — Página morta = estado fixo `cafeina: 1`.** Carinha `( ￣^￣)`, "tá chatinha… cadê o café?", cafeína vermelha. Coerente com as regras do coração: quando o post 5 ligar o estado real, a página não "muda de personalidade".
- **D9 — Barrinhas `■□`, não CSS.** Continuidade visual com o material de aula (terminal → HTML vira evolução, não ruptura) e a barra é só `String.duplicate/2` — o post 5 renderiza sem lógica nova.
- **D10 — `brincar` cortado.** Quatro ações = quatro botões = grid 2×2. Uma ação a menos não remove nenhum conceito.
