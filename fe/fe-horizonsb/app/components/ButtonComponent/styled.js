import styled from '@emotion/styled';

import { colors, ANIMATION_TIMING } from '../../identity/constants';
import { remCalc } from '../../lib/helperMethods';

const BASE_STYLES = {
  color: colors.WHITE_ALPHA_100,
  fontSize: remCalc(14),
  fontWeight: 600,
  lineHeight: remCalc(38),
  padding: `0 ${remCalc(26)}`,
  transition: `border 250ms ${ANIMATION_TIMING}, background 250ms ${ANIMATION_TIMING}`,

  '&:disabled': {
    opacity: 0.5,
  },
};

const BUTTON_STYLES = {
  default: {
    background: colors.BLACK_01,
    border: `4px solid ${colors.BLACK_01}`,

    '&:hover:enabled': {
      borderColor: colors.BLACK_02,
      background: colors.BLACK_01,
      cursor: 'pointer',
    },

    '&:focus': {
      background: colors.BLACK_01,
      outline: 'none',
    },

    '&:active': {
      background: colors.BLACK_01,
      borderColor: colors.BLACK_04,
    },
  },
  color: {
    background: colors.BRAND_PRIMARY,
    border: `4px solid ${colors.BRAND_PRIMARY}`,

    '&:hover:enabled': {
      cursor: 'pointer',
      borderColor: '#f36a35',
    },

    '&:focus': {
      background: '#ff4700',
      borderColor: '#ff4700',
      outline: 'none',
    },

    '&:active': {
      borderColor: colors.BLACK_04,
    },
  },
  secondary: {
    background: colors.WHITE_ALPHA_100,
    color: colors.BLACK_01,
    border: `2px solid ${colors.BLACK_01}`,
    lineHeight: remCalc(42),

    '&:hover:enabled': {
      cursor: 'pointer',
      background: colors.BLACK_04,
    },

    '&:focus': {
      outline: 'none',
    },

    '&:active': {
      background: colors.BLACK_01,
      color: colors.WHITE_ALPHA_100,
    },
  },
  ghost: {
    background: 'transparent',
    color: colors.WHITE_ALPHA_100,
    border: `2px solid ${colors.BLACK_02}`,
    lineHeight: remCalc(42),

    '&:hover:enabled': {
      cursor: 'pointer',
      border: `2px solid ${colors.WHITE_ALPHA_100}`,
    },

    '&:focus': {
      outline: 'none',
    },

    '&:active': {
      background: colors.WHITE_ALPHA_100,
      color: colors.BLACK_01,
    },
  },
};

const BUTTON_SIZE = {
  default: {
    padding: `0 ${remCalc(26)}`,
  },
  small: {
    padding: `0 ${remCalc(16)}`,
  },
  medium: {
    padding: `0 ${remCalc(40)}`,
  },
  large: {
    padding: `0 ${remCalc(60)}`,
  },
};

export const Button = styled.button(
  BASE_STYLES,
  ({ color }) => BUTTON_STYLES[color],
  ({ size }) => BUTTON_SIZE[size] || BUTTON_SIZE,
);
