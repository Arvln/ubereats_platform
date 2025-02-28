import { Prop, TChannelCategory } from './types';
import { useTranslations } from 'next-intl';
import Image from 'next/image';
import { CategoryItem } from 'components';

import classes from 'styles/features/ChannelCategory.module.scss';

const {
  wrapper,
  pageWrapper,
  categoryWrapper,
  category
} = classes;
const CATEGORY_ICONS_SERVER_HOST = process.env.CATEGORY_ICONS_SERVER_HOST;

function ChannelCategory({
  data: pages,
  pageOffset
}: Prop) {
  const t = useTranslations();

  function _renderCategory(categoies: TChannelCategory[]) {
    return (
      categoies.map(({
        title,
        name,
        uuid
      }) => (
        <div
          className={categoryWrapper}
          key={uuid}
        >
          <CategoryItem
            appendClass={category}
            pageUrl={`/${title}`}
            icon={
              <Image
                src={`https://${CATEGORY_ICONS_SERVER_HOST}/new_search_home_eats_icon/${name}_BrowseHome@3x.png`}
                width={68}
                height={80}
                alt={name}
              />
            }
            text={t(title.replace('-', '.'))}
          />
        </div>
      ))
    );
  };

  function _renderPages() {
    return (
      pages.map((categoies, index) => (
        <div
          className={pageWrapper}
          key={index}
        >
          {_renderCategory(categoies as TChannelCategory[])}
        </div>
      ))
    );
  };

  return (
    <div
      className={wrapper}
      style={{ transform: `translateX(${pageOffset}%)` }}
    >
      {_renderPages()}
    </div>
  );
};

export default ChannelCategory;
