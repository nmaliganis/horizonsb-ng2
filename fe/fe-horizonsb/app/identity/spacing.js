import { fromJS } from 'immutable';

import { remCalc } from '../lib/helperMethods';
import * as c from '../identity/constants';
import { capitalize } from '../lib/strings';

const spacingScale = {
  XS_MOBILE: remCalc(c.X_SMALL_MOBILE),
  XS_DESKTOP: remCalc(c.X_SMALL_DESKTOP),
  XS_DESKTOP_HD: remCalc(c.X_SMALL_DESKTOP_HD),

  SM_MOBILE: remCalc(c.SMALL_MOBILE),
  SM_DESKTOP: remCalc(c.SMALL_DESKTOP),
  SM_DESKTOP_HD: remCalc(c.SMALL_DESKTOP_HD),

  MD_MOBILE: remCalc(c.MEDIUM_MOBILE),
  MD_DESKTOP: remCalc(c.MEDIUM_DESKTOP),
  MD_DESKTOP_HD: remCalc(c.MEDIUM_DESKTOP_HD),

  LG_MOBILE: remCalc(c.LARGE_MOBILE),
  LG_DESKTOP: remCalc(c.LARGE_DESKTOP),
  LG_DESKTOP_HD: remCalc(c.LARGE_DESKTOP_HD),

  XL_MOBILE: remCalc(c.X_LARGE_MOBILE),
  XL_DESKTOP: remCalc(c.X_LARGE_DESKTOP),
  XL_DESKTOP_HD: remCalc(c.X_LARGE_DESKTOP_HD),
};

export const vertical = (spacing, type = 'margin') => ({
  [`${type}Top`]:
    typeof spacing === 'number'
      ? remCalc(spacing)
      : spacingScale[`${spacing.toUpperCase()}_MOBILE`] || spacing,
  [`${type}Bottom`]:
    typeof spacing === 'number'
      ? remCalc(spacing)
      : spacingScale[`${spacing.toUpperCase()}_MOBILE`] || spacing,

  [c.DESKTOP]: {
    [`${type}Top`]:
      typeof spacing === 'number'
        ? remCalc(spacing)
        : spacingScale[`${spacing.toUpperCase()}_DESKTOP`] || spacing,
    [`${type}Bottom`]:
      typeof spacing === 'number'
        ? remCalc(spacing)
        : spacingScale[`${spacing.toUpperCase()}_DESKTOP`] || spacing,
  },
  [c.DESKTOP_HD]: {
    [`${type}Top`]:
      typeof spacing === 'number'
        ? remCalc(spacing)
        : spacingScale[`${spacing.toUpperCase()}_DESKTOP_HD`] || spacing,
    [`${type}Bottom`]:
      typeof spacing === 'number'
        ? remCalc(spacing)
        : spacingScale[`${spacing.toUpperCase()}_DESKTOP_HD`] || spacing,
  },
});

export const horizontal = (spacing, type = 'margin') => ({
  [`${type}Left`]:
    typeof spacing === 'number'
      ? remCalc(spacing)
      : spacingScale[`${spacing.toUpperCase()}_MOBILE`] || spacing,
  [`${type}Right`]:
    typeof spacing === 'number'
      ? remCalc(spacing)
      : spacingScale[`${spacing.toUpperCase()}_MOBILE`] || spacing,

  [c.DESKTOP]: {
    [`${type}Left`]:
      typeof spacing === 'number'
        ? remCalc(spacing)
        : spacingScale[`${spacing.toUpperCase()}_DESKTOP`] || spacing,
    [`${type}Right`]:
      typeof spacing === 'number'
        ? remCalc(spacing)
        : spacingScale[`${spacing.toUpperCase()}_DESKTOP`] || spacing,
  },

  [c.DESKTOP_HD]: {
    [`${type}Left`]:
      typeof spacing === 'number'
        ? remCalc(spacing)
        : spacingScale[`${spacing.toUpperCase()}_DESKTOP_HD`] || spacing,
    [`${type}Right`]:
      typeof spacing === 'number'
        ? remCalc(spacing)
        : spacingScale[`${spacing.toUpperCase()}_DESKTOP_HD`] || spacing,
  },
});

export const regular = (spacing, type = 'margin') => ({
  [type]:
    typeof spacing === 'number'
      ? remCalc(spacing)
      : spacingScale[`${spacing.toUpperCase()}_MOBILE`] || spacing,

  [c.DESKTOP]: {
    [type]:
      typeof spacing === 'number'
        ? remCalc(spacing)
        : spacingScale[`${spacing.toUpperCase()}_DESKTOP`] || spacing,
  },

  [c.DESKTOP_HD]: {
    [type]:
      typeof spacing === 'number'
        ? remCalc(spacing)
        : spacingScale[`${spacing.toUpperCase()}_DESKTOP_HD`] || spacing,
  },
});

const vertOrHorizontal = {
  horizontal,
  vertical,
};

const buildProperties = (properties, prop) => {
  return properties.map(
    str =>
      str[0] !== 'all'
        ? { [`${prop}${capitalize(str[0])}`]: str[1] }
        : { [prop]: str[1] },
  );
};

export const spacing = sp => {
  const returnValue = {
    [c.DESKTOP]: {},
    [c.DESKTOP_HD]: {},
  };

  if (_.isEmpty(sp.margin) && _.isEmpty(sp.padding)) {
    return null;
  }

  return Object.keys(sp).reduce((space, prop) => {
    const propSplit = sp[prop].split(' ').map(s => s.split('-'));
    const properties = buildProperties(propSplit, prop);

    return properties.reduce((currentStyles, y, i) => {
      const key = Object.keys(y).toString();
      const val = y[key];
      const newStyles =
        key.includes('Vertical') || key.includes('Horizontal')
          ? vertOrHorizontal[`${propSplit[i][0]}`](propSplit[i][1], prop)
          : regular(val, key);

      return fromJS(currentStyles)
        .mergeDeep(newStyles)
        .toJS();
    }, space);
  }, returnValue);
};
