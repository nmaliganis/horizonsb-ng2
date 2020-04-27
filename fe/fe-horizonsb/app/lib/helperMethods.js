import _ from 'lodash';
import { round } from './numbers';

export const remCalc = (pixelValue, baseValue = 16) =>
  `${round(pixelValue / baseValue, 2)}rem`;

export const decodeVariantId = string => _.last(atob(string).split('/'));
