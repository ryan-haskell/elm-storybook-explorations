import React from 'react';
import { addons } from '@storybook/addons';
import { StoryPanel } from './StoryPanel';

const ADDON_ID = 'ryannhg/elm-source';
const PANEL_ID = `${ADDON_ID}/panel`;

addons.register(ADDON_ID, (api) => {
  addons.addPanel(PANEL_ID, {
    title: 'Source',
    render: ({ active, key }) => (active ? <StoryPanel key={key} api={api} /> : null),
    paramKey: 'elm-source',
  });
});