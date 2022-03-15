export const ElmComponent = {
  create: (elm, flags) => {
    const node = document.createElement('div')
    window.requestAnimationFrame(() => {
      let app = elm.init({ node, flags })

      // Handle Storybook actions
      if (app.ports && app.ports.logAction) {
        app.ports.logAction.subscribe(({ name, payload }) => {
          let logStorybookAction = flags[name]
          if (logStorybookAction) {
            logStorybookAction(payload || null)
          } else {
            console.warn(`Unhandled event: ${name}`)
          }
        })
      }
    })
    return node
  }
}