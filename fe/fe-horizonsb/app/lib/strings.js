import _ from 'lodash';

export const parameterize = (string: string): string =>
  string
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/(^-|-$)/g, '');

export const capitalize = (str: string): string => _.capitalize(str);

export const humanize = (str: string): string =>
  str
    .toString()
    .toLowerCase()
    .replace(/[_-]/g, ' ')
    .replace(/(?:^|\s)\S/g, a => a.toUpperCase());

export const getUrlParams = search => {
  if (search && typeof search === 'string') {
    const hasIndex = search.includes('?');
    const params = {};
    const hashes = hasIndex
      ? search.slice(search.indexOf('?') + 1).split('&')
      : [];

    hashes.map(hash => {
      const [key, val] = hash.split('=');
      params[key] = decodeURIComponent(val);
      return null;
    });

    return params;
  }

  return {};
};

export const convertToArray = (str: string): string[] => str.split('');
export const addCommas = str => str.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
export const stripDecimal = (str: string): string =>
  addCommas(str.split('.')[0]);
