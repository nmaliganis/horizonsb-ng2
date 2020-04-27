import styled from '@emotion/styled';

import * as s from '../spacing';

export default styled.div(
  ({ spacing }) => spacing && s.spacing(spacing),
  {
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
  },
  ({ alignment }) => ({
    textAlign: alignment || 'left',
  }),
);
