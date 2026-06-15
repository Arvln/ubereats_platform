'use client';

import { useQuery } from '@tanstack/react-query';
import { useState } from 'react';
import { useTranslations } from 'next-intl';
import Image from 'next/image';
import { blurDataURL } from 'lib/image-placeholder';
import { CategoryItem } from 'components';
import {
  homePageQueryOptions,
} from '../../queries';

import classes from '@/styles/features/Shortcut.module.scss';

const {
  wrapper,
  shortcutItemWrapper,
  itemHoverStyle,
} = classes;
const SHORTCUT_ICONS_SERVER_HOST = process.env.SHORTCUT_ICONS_SERVER_HOST;

function Shortcut() {
  const t = useTranslations();
  const [selectedId, setSelectedId] = useState<string>('');
  const { data: shortcut = [] } = useQuery({
    ...homePageQueryOptions,
    select: (pageData) => pageData.shortcut,
  });

  function _handleMouseEnter(selectedId: string): void {
    setSelectedId(selectedId);
  };

  function _handleMouseLeave(): void {
    setSelectedId('');
  };

  function _renderItems(): JSX.Element[] {
    return (
      shortcut.map(({
        title,
        imageSuffix,
        isCuisines,
        uuid
      }) => {
        const isSelected: boolean = uuid === selectedId;
        const hoverStyle: string = isSelected ? itemHoverStyle : '';

        return (
          <li
            key={uuid}
            onMouseEnter={() => _handleMouseEnter(uuid)}
            onMouseLeave={() => _handleMouseLeave()}
          >
            <CategoryItem
              appendClass={shortcutItemWrapper}
              pageUrl={`/${title}`}
              icon={
                <Image
                  className={hoverStyle}
                  src={`https://${SHORTCUT_ICONS_SERVER_HOST}/shortcuts${isCuisines ? `/cuisines/` : '/'}${imageSuffix}`}
                  width={60}
                  height={60}
                  placeholder="blur"
                  blurDataURL={blurDataURL}
                  alt={title}
                />
              }
              text={t(title.replace('-', '.'))}
            />
          </li>
        )
      })
    );
  };

  return (
    <div className={wrapper}>
      <nav>
        <ul>
          {_renderItems()}
        </ul>
      </nav>
    </div>
  );
};

export default Shortcut;
