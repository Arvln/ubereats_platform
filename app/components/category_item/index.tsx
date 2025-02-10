import { useLocale } from 'contexts/LocaleContext';
import { Prop } from './types';
import Link from 'next/link';

import classes from 'styles/components/CategoryItem.module.scss';

const { wrapper } = classes;

function CategoryItem({
  appendClass,
  pageUrl,
  icon,
  text
}: Prop) {
  const { locale } = useLocale();
  const wrapperStyle = `${wrapper} ${appendClass}`;

  return (
    <div className={wrapperStyle} data-testid="category-item-wrapper">
      <Link href={`/${locale}${pageUrl}`}>
        {icon}
        <span data-testid="category-item-content">{text}</span>
      </Link>
    </div>
  );
};

export default CategoryItem;
