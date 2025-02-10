import Button from 'components/button';
import { useLocale } from 'contexts';
import { useTranslations } from 'next-intl';
import Image from 'next/image';
import Link from 'next/link';
import { useState } from 'react';

import classes from 'styles/features/Footer.module.scss';

const {
  wrapper,
  moreOptionsWrapper,
  brand,
  logoWrapper,
  download,
  moreOptions,
  selectLanguage,
  about,
  socialMedia,
  policy,
  statement,
  space_8,
  space_16,
  space_24,
  space_40
} = classes;

const Modal = ({ isOpen, onClose, children }: {
  isOpen: boolean;
  onClose: () => void;
  children: React.ReactNode;
}) => {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 flex items-start justify-center pt-20 z-50" style={{ backgroundColor: 'rgba(38, 38, 38, .8)' }} onClick={onClose}>
      <div className="bg-white rounded-2xl w-[28rem]" onClick={(e) => e.stopPropagation()}>
        <Button
          onClick={onClose}
          appendClass={{
            appendWrapper: 'w-12 h-12 flex justify-center items-center bg-white ml-2 mt-2',
            appendContent: ''
          }}
          icon={
            <Image
              src="/images/close.svg"
              width="24"
              height="24"
              alt="Close"
            />
          }
        />
        {children}
      </div>
    </div>
  );
};

function Footer() {
  const t = useTranslations();
  const { locale, changeLocale } = useLocale();
  const [isLocaleSwitchModalOpen, setIsLocaleSwitchModalOpen] = useState(false);

  function _renderMoreOptions() {
    const wrapper = moreOptionsWrapper;

    return (
      <div className={wrapper}>
        <div className={brand}>
          <div className={logoWrapper}>
            <Image
              src="/images/footer_logo.svg"
              width={146}
              height={24}
              alt="Logo"
            />
          </div>
          <div className={download}>
            <Link href="https://apps.apple.com/us/app/uber-eats-food-delivery/id1058959277">
              <Image
                src="/images/app_store.svg"
                width={135}
                height={40}
                alt="App Store"
              />
            </Link>
            <div className={space_16} />
            <Link href="https://play.google.com/store/apps/details?id=com.ubercab.eats">
              <Image
                src="/images/google_play.png"
                width={135}
                height={40}
                alt="Google Play"
              />
            </Link>
          </div>
        </div>
        <div className={moreOptions}>
          <ul>
            <li>
              <Link href="https://help.uber.com/ubereats">{t('footer.get-help')}</Link>
            </li>
            <li>
              <Link href="https://www.ubereats.com/restaurant">{t('common.add-your-restaurant')}</Link>
            </li>
            <li>
              <Link href="https://www.uber.com/drive/delivery">{t('common.register-as-delivery-partner')}</Link>
            </li>
            <li>
              <Link href="https://www.uber.com/business/eats">{t('common.create-business-account')}</Link>
            </li>
            <li>
              <Link href="#">{t('footer.enjoy-a-discount-on-your-first-order')}</Link>
            </li>
          </ul>
        </div>
        <div className={moreOptions}>
          <ul>
            <li>
              <Link href="https://www.ubereats.com/tw/near-me">{t('footer.food-delivery-near-me')}</Link>
            </li>
            <li>
              <Link href="https://www.ubereats.com/tw/location">{t('footer.view-all-cities')}</Link>
            </li>
            <li>
              <Link href="https://www.ubereats.com/tw/location#all-countries">{t('footer.view-all-countries-regions')}</Link>
            </li>
            <li>
              <Link href="https://www.uber.com/blog/eat">{t('footer.read-our-blog')}</Link>
            </li>
            <li>
              <Link href="https://about.ubereats.com">{t('footer.about-ubereats')}</Link>
            </li>
            <li>
              <span className={selectLanguage} onClick={() => setIsLocaleSwitchModalOpen(true)}>
                <Image
                  src="/images/chinese.svg"
                  width={16}
                  height={15}
                  alt="Chinese"
                />
                <div className={space_8} />
                <span>{t(`footer.${locale}`)}</span>
              </span>
            </li>
            <Modal isOpen={isLocaleSwitchModalOpen} onClose={() => setIsLocaleSwitchModalOpen(false)}>
              <div className="p-6">
                <h1 className="text-xl font-medium text-4xl pb-6">{t('footer.select-a-language')}</h1>
                {['zh-TW', 'en-US'].map((language) => (
                  <div
                    key={language}
                    className="mb-6 flex justify-between cursor-pointer"
                    onClick={() => {
                      changeLocale(language);
                      setIsLocaleSwitchModalOpen(false);
                    }}
                  >
                    <span>{t(`footer.${language}`)}</span>
                    {(locale === language) && <Image
                      src="/images/checkmark.svg"
                      width="16"
                      height="16"
                      alt="Checkmark"
                    />}
                  </div>
                ))}
              </div>
            </Modal>
          </ul>
        </div>
      </div>
    );
  };

  return (
    <footer className={wrapper}>
      {_renderMoreOptions()}
      <hr />
      <div className={about}>
        <div className={socialMedia}>
          <Link
            href="https://www.facebook.com/ubereats"
          >
            <Image
              src="/images/facebook.svg"
              width={16}
              height={16}
              alt="Facebook"
            />
          </Link>
          <div className={space_24} />
          <Link
            href="https://www.twitter.com/ubereats"
          >
            <Image
              src="/images/twitter.svg"
              width={16}
              height={16}
              alt="Twitter"
            />
          </Link>
          <div className={space_24} />
          <Link
            href="https://www.instagram.com/ubereats"
          >
            <Image
              src="/images/instagram.svg"
              width={16}
              height={16}
              alt="Instagram"
            />
          </Link>
        </div>
        <div className={policy}>
          <Link href="https://www.uber.com/legal/privacy/users">{t('footer.privacy-policy')}</Link>
          <div className={space_40} />
          <Link href="https://www.uber.com/terms">{t('footer.terms')}</Link>
          <div className={space_40} />
          <Link href="https://help.uber.com/ubereats/article/uber-eats-pricing?nodeId=2adbed88-9822-4690-9529-3061c4821755">{t('footer.pricing')}</Link>
          <div className={space_40} />
          <Link href="https://privacy.uber.com/privacy/california">{t('footer.do-not-sell-my-info')}</Link>
        </div>
      </div>
      <div className={statement}>
        <div>
          {t('footer.policy-statement-1')}
          <Link
            href="https://policies.google.com/privacy"
            className="hover:underline"
          >
            {t('footer.policy-statement-2')}
          </Link>
          {t('footer.policy-statement-3')}
          <Link
            href="https://policies.google.com/terms"
            className="hover:underline"
          >
            {t('footer.policy-statement-4')}
          </Link>
          {t('footer.policy-statement-5')}
        </div>
        <div className={space_40} />
        <div>© 2025 Uber Technologies Inc.</div>
      </div>
    </footer>
  );
};

export default Footer;
