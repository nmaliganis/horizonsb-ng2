import React from 'react'
import Button from '../../components/ButtonComponent';

import { Main, Oops, Message, ErrorMessage, TextWrapper } from './styled';

const NotFound = () => (
  <Main>
    <Message>
      <Oops>Oops.</Oops>
      <TextWrapper>
        <ErrorMessage>It looks like you took a wrong turn.
          The page you're looking for can't be found.
        </ErrorMessage>
      </TextWrapper>
      <Button children="Back to Home" theme="secondary" href="/" />
    </Message>
  </Main>
);
export default NotFound
