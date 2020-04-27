import styled from '@emotion/styled';
import TypeScale from '../../identity/type';
import { spacing } from '../../identity/spacing';
import * as w from '../../identity/wrappers';
import img from '../../static/assets/bg-city-map.png';

export const Oops = styled(TypeScale.H1)({});
export const ErrorMessage = styled(TypeScale.H3)({
  margin: '0 auto',
});

export const Main = styled(w.Main)({
  position: 'relative',
  minHeight: '100vh',
  background: `url(${img})`,
  backgroundSize: 'cover',
  display: 'flex',
});

export const TextWrapper = styled.div({
  ...spacing({ margin: 'top-sm bottom-lg' }),
});

export const Message = styled.div({
  ...spacing({ padding: 'horizontal-sm vertical-md' }),
  maxWidth: '550px',
  display: 'flex',
  flexDirection: 'column',
  margin: '0 auto',
  alignSelf: 'center',
  textAlign: 'center',
});
