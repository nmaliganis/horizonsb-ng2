import React from 'react';
import { Link } from 'react-router-dom'

import { Button } from './styled';

type Props = {
  children: string,
  theme: string,
  href: ?string,
  as?: ?string,
  onClick: ?() => mixed,
  disabled: boolean,
  size: string,
};

const ButtonComponent = ({
                           children,
                           theme,
                           onClick,
                           href,
                           disabled,
                           size,
                         }: Props) =>
  href ? (
    <Link to={href}>
        <Button size={size} color={theme}>
          {children}
        </Button>
    </Link>
  ) : (
    <Button size={size} disabled={disabled} onClick={onClick} color={theme}>
      {children}
    </Button>
  );

ButtonComponent.defaultProps = {
  onClick: null,
  disabled: false,
  as: null,
  href: null,
  theme: 'default',
  children: 'Click Me',
  size: 'default',
};

export default ButtonComponent;
