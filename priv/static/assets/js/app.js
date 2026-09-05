// Sem bundler aqui: phoenix.js e phoenix_live_view.js são copiados
// dos deps e expõem os globais `Phoenix` e `LiveView`.
const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")

const liveSocket = new LiveView.LiveSocket("/live", Phoenix.Socket, {
  params: {_csrf_token: csrfToken},
})

liveSocket.connect()

// expõe no console do navegador pra brincar:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)
window.liveSocket = liveSocket
