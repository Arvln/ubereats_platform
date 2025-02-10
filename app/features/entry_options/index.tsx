import { TAppendClass } from 'components/button/types';
import { useTranslations } from 'next-intl';
import Link from 'next/link';
import Image from 'next/image';
import { Button } from 'components';

import classes from 'styles/features/EntryOptions.module.scss';

const {
  wrapper,
  login,
  register,
  download,
  imageWrapper,
  source,
  buttonWrapper,
  buttonContent,
  space_8,
  space_16
} = classes;
const sourceButton: TAppendClass = {
  appendWrapper: buttonWrapper,
  appendContent: buttonContent
}

function EntryOptions() {
  const t = useTranslations();
  function _renderDownloadOptions() {
    return (
      <div>
        <div className={download}>
          <div className={imageWrapper}>
            <Image
              src="/images/download.svg"
              layout="fill"
              alt="Uber Eats 優食"
            />
          </div>
          <div className={space_16} />
          <p>{t('entry-options.the-app-brings-you-more-delicious-dishes')}</p>
        </div>
        <div className={source}>
          <Link
            href="https://apps.apple.com/us/app/uber-eats-food-delivery/id1058959277"
          >
            <Button
              appendClass={sourceButton}
              icon={
                <Image
                  src="/images/ios.svg"
                  width="16"
                  height="16"
                  alt="iPhone"
                />
              }
              text="iPhone"
            />
          </Link>
          <div className={space_8} />
          <Link
            href="https://play.google.com/store/apps/details?id=com.ubercab.eats"
          >
            <Button
              appendClass={sourceButton}
              icon={
                <Image
                  src="/images/android.svg"
                  width="16"
                  height="16"
                  alt="Android"
                />
              }
              text="Android"
            />
          </Link>
        </div>
      </div>
    );
  };

  return (
    <div
      className={wrapper}
      onClick={event => event.stopPropagation()}
    >
      <div>
        <Link href="#">
          <span className={login}>{t('common.login')}</span>
        </Link>
        <div className={register}>
          <li>{t('common.create-business-account')}</li>
          <li>{t('common.add-your-restaurant')}</li>
          <li>{t('common.register-as-delivery-partner')}</li>
        </div>
      </div>
      {_renderDownloadOptions()}
    </div>
  );
};

export default EntryOptions;
