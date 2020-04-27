import styled from '@emotion/styled';

import {
  TYPE_SCALE,
  DESKTOP,
  DESKTOP_HD,
  MEASURE,
  uiColors,
} from '../constants';

import * as s from '../spacing';
import { remCalc } from '../../lib/helperMethods';

export const FONT_CONDENSED =
  '"acumin-pro-condensed", “Helvetica Neue”, Helvetica, Arial, sans-serif';
export const FONT_EXTRA_CONDENSED =
  '"acumin-pro-extra-condensed", “Helvetica Neue”, Helvetica, Arial, sans-serif';

const typeMapper = scale =>
  // First we need to map over the keys of the scale and reduce them to
  // return a object.
  // typeObject - The previous accumalated object.
  // el - The current element we are working on.
  Object.keys(scale).reduce(
    (typeObject, el) => ({
      // Merge in our base object so the previous elements will be there
      ...typeObject,

      // Take the new element and start building it. Since it will start
      // as a capitalized element, lowercase it and then add the font sizes
      // for DESKTOP and DESKTOP_HD.
      [el]: styled(el.toLowerCase())(
        ({ spacing }) => spacing && s.spacing(spacing),
        ({ color }) => ({ color: color || uiColors.TEXT_COLOR }),
        ({ alignText }) => ({ textAlign: alignText || 'left' }),
        ({ fontWeight }) => ({
          fontWeight: fontWeight || scale[el].FONT_WEIGHT,
        }),
        ({ letterSpacing }) => ({ letterSpacing }),
        ({ fontFamily }) => ({
          fontFamily: fontFamily || scale[el].FONT_FAMILY,
        }),
        ({ lineHeight }) => ({
          lineHeight: lineHeight || scale[el].LINE_HEIGHT,
        }),
        ({ muted }) => muted && { color: uiColors.TEXT_MUTED },
        ({ allUppercase }) => allUppercase && { textTransform: 'uppercase' },
        ({ semiMuted }) => semiMuted && { color: uiColors.TEXT_SEMI_MUTED },
        ({ displayFont }) =>
          displayFont && {
            fontFamily: FONT_CONDENSED,
            textTransform: 'uppercase',
            letterSpacing:
              scale[el].DISPLAY_LETTER_SPACING &&
              scale[el].DISPLAY_LETTER_SPACING,
            fontWeight: 700,
            lineHeight: 1.06,
          },
        ({ hero, semi }) => {
          if ((hero || semi) && el === 'H1') {
            return { fontFamily: FONT_EXTRA_CONDENSED };
          }

          if (hero || semi) {
            return { fontFamily: FONT_CONDENSED };
          }

          return null;
        },
        ({ hero, semi }) =>
          (hero || semi) && {
            lineHeight: 1.06,
            textTransform: 'uppercase',
            letterSpacing:
              scale[el].DISPLAY_LETTER_SPACING &&
              scale[el].DISPLAY_LETTER_SPACING,
          },
        ({ measure }) =>
          measure !== 'no-measure' && {
            width: '100%',

            [DESKTOP]: {
              maxWidth:
                MEASURE[`${measure && measure.toUpperCase()}`] ||
                MEASURE.MEDIUM,
            },
          },
        {
          fontSize: scale[el].BASE && remCalc(scale[el].BASE),

          [DESKTOP]: {
            fontSize: scale[el].DESKTOP && remCalc(scale[el].DESKTOP),
          },

          [DESKTOP_HD]: {
            fontSize: scale[el].DESKTOP_HD && remCalc(scale[el].DESKTOP_HD),
          },
        },
        ({ hero }) =>
          hero && {
            fontSize: scale[el].MAIN && remCalc(scale[el].MAIN.BASE),
            fontWeight: 800,

            [DESKTOP]: {
              fontSize: scale[el].MAIN && remCalc(scale[el].MAIN.DESKTOP),
              maxWidth: '100%',
            },

            [DESKTOP_HD]: {
              fontSize: scale[el].MAIN && remCalc(scale[el].MAIN.DESKTOP_HD),
            },
          },
      ),
    }),
    {},
  );

export default typeMapper(TYPE_SCALE);
