import type { Metadata } from 'next';
import Image from 'next/image';

import classes from 'styles/pages/Error.module.scss';

export const metadata: Metadata = {
  title: '糟糕！發生錯誤 | Uber Eats 優食',
};

const {
  wrapper,
  content,
  imageWrapper,
  title,
} = classes;

export default function NotFound() {
  return (
    <div className={wrapper}>
      <div className={content}>
        <div className={imageWrapper}>
          <Image
            src="/images/error.svg"
            width={226}
            height={160}
            alt="Error"
          />
        </div>
        <div className={title}>糟糕！發生錯誤</div>
        <div>處理您的預約時發生錯誤。請稍後再試。</div>
      </div>
    </div>
  );
}
