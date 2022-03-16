import React from 'react';
import { useParameter } from '@storybook/api';

import { PrismLight as SyntaxHighlighter } from 'react-syntax-highlighter';
import { oneLight } from 'react-syntax-highlighter/dist/esm/styles/prism'
import elm from 'react-syntax-highlighter/dist/esm/languages/prism/elm'
SyntaxHighlighter.registerLanguage('elm', elm)

export const StoryPanel = () => {
  const elmSource = useParameter('elmSource', null);
  
  return elmSource ? (
    <SyntaxHighlighter
      language="elm"
      style={oneLight}
      showLineNumbers={true}
    >
      {elmSource}
    </SyntaxHighlighter>
  ) : null;
};