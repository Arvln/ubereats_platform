import { Prop } from './types';

import classes from 'styles/components/Button.module.scss';

const {
  wrapper,
  content,
} = classes;

function Button({
  appendClass,
  icon,
  text,
  ...restProps
}: Prop) {
  const {
    appendWrapper,
    appendContent,
  } = appendClass;
  const wrapperStyle = `${wrapper} ${appendWrapper}`;
  const contentStyle = `${content} ${appendContent}`;

  return (
    <div className={wrapperStyle} data-testid="button-wrapper" {...restProps}>
      {icon}
      <div className={contentStyle} data-testid="button-content">{text}</div>
    </div>
  );
};

export default Button;
