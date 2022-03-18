export const ElmComponent = {
  create: (elm, controls) => {
    const node = document.createElement('div')
    window.requestAnimationFrame(() => {
      let app = elm.init({ node, flags: controls })

      // This allows us to log Elm messages in 
      // Storybook's "Actions" tab!
      if (app.ports && app.ports.logAction) {
        app.ports.logAction.subscribe(({ payload }) => {
          if (controls.onAction) {
            controls.onAction(payload || null)
          } else {
            if (process.env.NODE_ENV === 'development') {
              window.alert(actionsArgMissingError)
            }
            console.warn(actionsArgMissingError)
          }
        })
      }
    })
    return node
  }
}

const actionsArgMissingError = [
  `This story is missing the "onAction" control required to log Elm messages in the "Actions" tab.`,
  `You can fix this by adding { onAction: { action: 'Elm' } } to this story's "argTypes" section.`
].join('\n\n')