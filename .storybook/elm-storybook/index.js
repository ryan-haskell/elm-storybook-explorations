export const ElmComponent = {
  create: (elm, flags) => {
    const node = document.createElement('div')
    window.requestAnimationFrame(() => {
      let app = elm.init({ node, flags })

      // Handle Storybook actions
      if (app.ports && app.ports.logAction) {
        app.ports.logAction.subscribe(({ actionName, payload }) => {
          let logStorybookAction = flags[actionName]
          if (logStorybookAction) {
            logStorybookAction(payload || null)
          } else {
            console.warn(`Unhandled event: ${actionName}`)
          }
        })
      }
    })
    return node
  }
}