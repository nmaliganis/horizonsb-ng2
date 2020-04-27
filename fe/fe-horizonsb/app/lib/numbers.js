export const even = i => (i + 1) % 2;
export const percentage = (i1, i2) => `${(i1 / i2) * 100}%`;
export const clamp = (val, min, max) => Math.min(Math.max(val, min), max);
export const interpolate = (start, end, val) => (1 - val) * start + val * end;

export const round = (value, precision = 0) => {
  const mult = 10 ** precision;
  return Math.round(value * mult) / mult;
};

export const position = (range, time, base = 0, offset = 0) =>
  base + clamp(time - offset, 0, 1) * range;

export const convertToFixed = (num: number): string => num.toFixed(1);

export const dollarToCents = (num: number): number =>
  parseInt(`${num}`.replace(/[^0-9.]/g, ''), 0) * 100;

export const base64ToInteger = (string: string) => {
  const decoded = window.atob(string);
  const split = decoded.split('/');
  return parseInt(split[split.length - 1]);
};
