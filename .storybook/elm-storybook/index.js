export const ElmComponent = {
  create: (elm, flags) => {
    const node = document.createElement('div')
    window.requestAnimationFrame(() => {
      elm.init({ node, flags })
    })
    return node
  }
}