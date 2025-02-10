import { Prop } from './types';
import { useTranslations } from 'next-intl';
import Image from 'next/image';
import { RecommandCategories } from 'enums/features/category';

import classes from 'styles/features/category/Title.module.scss';

const {
  wrapper,
  background,
  topBackground,
  bottomBackground,
  left,
  right,
  content,
  text,
  imageWrapper
} = classes;
const {
  PET,
  FLOWERS,
  RETAIL
} = RecommandCategories;

function Title({ title, iconUrl }: Prop) {
  const t = useTranslations();
  function _renderImage(): JSX.Element | void {
    if (title === PET || title === FLOWERS || title === RETAIL) return;

    return (
      <div className={imageWrapper}>
        <Image
          src={iconUrl}
          layout="fill"
          alt={title}
        />
      </div>
    );
  };

  return (
    <div className={wrapper}>
      <div className={background}>
        <div className={topBackground} />
        <div className={bottomBackground}>
          <div className={left} />
          <div className={right} />
        </div>
      </div>
      <div className={content}>
        <div className={text}>{t(title.replace('-', '.'))}</div>
        {_renderImage()}
      </div>
    </div>
  );
};

export default Title;
