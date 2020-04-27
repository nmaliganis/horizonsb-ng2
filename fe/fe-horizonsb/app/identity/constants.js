/*
 * Colors:
 */
export const colors = {
  BLACK_00: '#000',
  BLACK_01: '#222222',
  BLACK_02: '#666666',
  BLACK_03: '#b4b4b4',
  BLACK_04: '#dddddd',
  BLACK_05: '#f2f2f2',

  WHITE_ALPHA_100: '#ffffff',

  BRAND_PRIMARY: '#f44805',
  BRAND_SECONDARY: '#c0a987',
};

export const uiColors = {
  LINK_COLOR: colors.BRAND_PRIMARY,
  TEXT_COLOR: colors.BLACK_01,
  TEXT_MUTED: colors.BLACK_03,
  TEXT_SEMI_MUTED: colors.BLACK_02,
  MODAL_TEXT: '#434343',

  SUCCESS_COLOR: colors.BRAND_PRIMARY,
  INVALID_FORM_COLOR: '#de1515',
  ERROR_COLOR: colors.BRAND_PRIMARY,
  REMOVE_CART_ITEM_COLOR: '#208EBF',

  BODY_BACKGROUND_COLOR: colors.BLACK_05,
  DARK_BACKGROUND_COLOR: '#030303',
};

export const gridColors = {
  BACKGROUND: '#FAFAFA',
  GRID_LINE: colors.BLACK_04,
};
export const themeBgColors = {
  Dark: uiColors.DARK_BACKGROUND_COLOR,
  Light: uiColors.BODY_BACKGROUND_COLOR,
  White: colors.WHITE_ALPHA_100,
};

/*
 * Spacing:
 */
export const PAGE_WRAPPER_SPACING_DESKTOP_HD = '7vw';
export const PAGE_WRAPPER_SPACING_DESKTOP = PAGE_WRAPPER_SPACING_DESKTOP_HD;
export const PAGE_WRAPPER_SPACING_MOBILE = PAGE_WRAPPER_SPACING_DESKTOP_HD;
export const PAGE_MAX_WIDTH = 1160;
export const GRID_TOTAL_COLUMNS = 12;

export const X_LARGE_MOBILE = 88;
export const X_LARGE_DESKTOP = 102;
export const X_LARGE_DESKTOP_HD = 118;

export const LARGE_MOBILE = 54;
export const LARGE_DESKTOP = 60;
export const LARGE_DESKTOP_HD = 66;

export const MEDIUM_MOBILE = 27;
export const MEDIUM_DESKTOP = 30;
export const MEDIUM_DESKTOP_HD = 33;

export const SMALL_MOBILE = 15;
export const SMALL_DESKTOP = 18;
export const SMALL_DESKTOP_HD = 22;

export const X_SMALL_MOBILE = 7;
export const X_SMALL_DESKTOP = 7;
export const X_SMALL_DESKTOP_HD = 7;

/*
 * Page Layout -
 */
export const PAGE_SPACING: number = 7;

export const COLUMNS_MOBILE: number = 3;
export const COLUMNS_TABLET: number = 6;
export const COLUMNS_DESKTOP: number = 12;
export const COLUMNS_DESKTOP_HD: number = 12;
export const COLUMN_SPACING: number = 1;
export const COLUMN_WIDTH: number = (115 / PAGE_MAX_WIDTH) * 100;

/*
 * Screen sizes:
 *
 * For our screen sizes we go with min width, meaning that we start with
 * mobile styles an go up.
 */
export const TABLET = '@media (min-width: 768px)';
export const DESKTOP = '@media (min-width: 1024px)';
export const CAROUSEL_HEADER = '@media (min-width: 1220PX)';
export const DESKTOP_HD = '@media (min-width: 1440px)';

/*
 * Typography styles
 *
 */
export const FONT_FAMILY_SANS_SERIF =
  '"acumin-pro", “Helvetica Neue”, Helvetica, Arial, sans-serif';
export const FONT_FAMILY_SERIF = '"Courier New", monospace, serif';
export const FONT_FAMILY_BASE = FONT_FAMILY_SANS_SERIF;
export const FONT_COLOR_BASE = uiColors.TEXT_COLOR;

export const FONT_COLOR_MUTED = '#666';

export const FONT_WEIGHT_LIGHT = 500;
export const FONT_WEIGHT_NORMAL = 400;
export const FONT_WEIGHT_BOLD = 700;

export const MEASURE = {
  SMALL: '30rem',
  MEDIUM: '40rem',
  LARGE: '45rem',
};

export const LINE_HEIGHT_BASE = 1.32;
export const LINE_HEIGHT_BODY = 1.55;
export const FONT_WEIGHT_BASE = FONT_WEIGHT_NORMAL;

export const LINE_HEIGHT_HEADINGS = 1.32;
export const FONT_FAMILY_HEADINGS = FONT_FAMILY_BASE;
export const FONT_WEIGHT_HEADINGS = FONT_WEIGHT_BOLD;
export const FONT_COLOR_HEADINGS = FONT_COLOR_BASE;

export const TYPE_SCALE = {
  H1: {
    BASE: 48,
    DESKTOP: 48,
    DESKTOP_HD: 48,
    LINE_HEIGHT: LINE_HEIGHT_HEADINGS,
    FONT_FAMILY: FONT_FAMILY_HEADINGS,
    FONT_WEIGHT: 700,
    DISPLAY_LETTER_SPACING: 0.12,
    MAIN: {
      BASE: 58,
      DESKTOP: 88,
      DESKTOP_HD: 88,
    },
  },

  H2: {
    BASE: 32,
    DESKTOP: 32,
    DESKTOP_HD: 32,
    LINE_HEIGHT: LINE_HEIGHT_HEADINGS,
    FONT_FAMILY: FONT_FAMILY_HEADINGS,
    FONT_WEIGHT: 700,
    DISPLAY_LETTER_SPACING: 0.1,
  },

  H3: {
    BASE: 28,
    DESKTOP: 28,
    DESKTOP_HD: 28,
    LINE_HEIGHT: LINE_HEIGHT_HEADINGS,
    FONT_FAMILY: FONT_FAMILY_HEADINGS,
    FONT_WEIGHT: 600,
    DISPLAY_LETTER_SPACING: 0.08,
  },

  H4: {
    BASE: 20,
    DESKTOP: 20,
    DESKTOP_HD: 20,
    LINE_HEIGHT: LINE_HEIGHT_HEADINGS,
    FONT_FAMILY: FONT_FAMILY_HEADINGS,
    FONT_WEIGHT: 600,
    DISPLAY_LETTER_SPACING: 1,
  },

  H5: {
    BASE: 16,
    DESKTOP: 16,
    DESKTOP_HD: 16,
    LINE_HEIGHT: LINE_HEIGHT_HEADINGS,
    FONT_FAMILY: FONT_FAMILY_HEADINGS,
    FONT_WEIGHT: 600,
    DISPLAY_LETTER_SPACING: 1,
  },

  H6: {
    BASE: 13,
    DESKTOP: 13,
    DESKTOP_HD: 13,
    LINE_HEIGHT: LINE_HEIGHT_HEADINGS,
    FONT_FAMILY: FONT_FAMILY_HEADINGS,
    FONT_WEIGHT: 600,
    DISPLAY_LETTER_SPACING: 0.04,
  },

  P: {
    BASE: 16,
    DESKTOP: 16,
    DESKTOP_HD: 16,
    LINE_HEIGHT: LINE_HEIGHT_BODY,
    FONT_FAMILY: FONT_FAMILY_BASE,
    FONT_WEIGHT: 400,
    DISPLAY_LETTER_SPACING: 0.04,
  },

  Li: {
    BASE: 16,
    DESKTOP: 16,
    DESKTOP_HD: 16,
    LINE_HEIGHT: LINE_HEIGHT_BASE,
    FONT_FAMILY: FONT_FAMILY_BASE,
    FONT_WEIGHT: 400,
    DISPLAY_LETTER_SPACING: 0.04,
  },

  Pre: {},
  Span: {},

  Small: {
    BASE: 14,
    DESKTOP: 14,
    DESKTOP_HD: 14,
    LINE_HEIGHT: LINE_HEIGHT_BASE,
    FONT_FAMILY: FONT_FAMILY_BASE,
    FONT_WEIGHT: 400,
    DISPLAY_LETTER_SPACING: 0.04,
  },
};

export const ABSOLUTE = {
  position: 'absolute',
  top: 0,
  left: 0,
  width: '100%',
  height: '100%',
};

export const FIXED = {
  position: 'fixed',
  top: 0,
  left: 0,
  width: '100%',
  height: '100%',
};

export const ANIMATION_TIMING = 'cubic-bezier(0.23, 1, 0.32, 1)';

export const ANIMATION = {
  timing: 'cubic-bezier(0.23, 1, 0.32, 1)',
  durationShort: '200ms',
  durationLong: '700ms',
};

export const TRANSITION = (
  duration: number = 350,
  delay: number = 0,
): { ease: Array<number>, duration: number, delay: number } => ({
  ease: [0.23, 1, 0.32, 1],
  duration,
  delay,
});
