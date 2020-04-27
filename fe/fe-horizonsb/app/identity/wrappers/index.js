import * as s from '../../identity/spacing';

import styled from '@emotion/styled';
import TextWrapper from './TextWrapper';
import Main from './Main';

const BaseWrapper = styled.div(
  ({ spacing }) => spacing && s.spacing(spacing),
  { position: 'relative' },
);

export { Main, TextWrapper, BaseWrapper };
