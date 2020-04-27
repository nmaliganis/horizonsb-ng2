import styled from '@emotion/styled';

import * as spacingCalculator from '../spacing';
import { remCalc } from '../../lib/helperMethods';
import { themeBgColors, DESKTOP } from '../constants';

export default styled.main(
  ({ spacing }) => spacing && spacingCalculator.spacing(spacing),
  {
    transition: 'all 100ms easeOut',
    position: 'relative',
    paddingTop: remCalc(50),
  },
  ({ bannerOpen }) => ({
    paddingTop: bannerOpen ? remCalc(130) : remCalc(70),

    [DESKTOP]: {
      paddingTop: bannerOpen ? remCalc(115) : remCalc(70),
    },
  }),
  ({ color }) => ({
    background: themeBgColors[color] || themeBgColors.White,
  }),
  ({ overflow }) => ({ overflow }),
);
