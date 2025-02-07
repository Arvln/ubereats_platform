import Button from 'components/button';
import { useLocale } from 'contexts/LocaleContext';
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
  const { locale } = useLocale();
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
              <Link href="https://help.uber.com/ubereats">取得協助</Link>
            </li>
            <li>
              <Link href="https://www.ubereats.com/restaurant">新增您的餐廳</Link>
            </li>
            <li>
              <Link href="https://www.uber.com/drive/delivery">註冊成為合作外送夥伴</Link>
            </li>
            <li>
              <Link href="https://www.uber.com/business/eats">建立企業帳戶</Link>
            </li>
            <li>
              <Link href="#">首份訂單可享折扣優惠</Link>
            </li>
          </ul>
        </div>
        <div className={moreOptions}>
          <ul>
            <li>
              <Link href="https://www.ubereats.com/tw/near-me">我附近的美食外送</Link>
            </li>
            <li>
              <Link href="https://www.ubereats.com/tw/location">檢視所有城市</Link>
            </li>
            <li>
              <Link href="https://www.ubereats.com/tw/location#all-countries">查看所有國家/地區</Link>
            </li>
            <li>
              <Link href="https://www.uber.com/blog/eat">閱讀我們的部落格</Link>
            </li>
            <li>
              <Link href="https://about.ubereats.com">關於 Uber Eats</Link>
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
                <span>中文</span>
              </span>
            </li>
            <Modal isOpen={isLocaleSwitchModalOpen} onClose={() => setIsLocaleSwitchModalOpen(false)}>
              <div className="p-6">
                <h1 className="text-xl font-medium text-4xl pb-6">選擇語言</h1>
                {['zh-TW', 'en-US'].map((language) => (
                  <div key={language} className="mb-6 flex justify-between cursor-pointer">
                    <span>{language}</span>
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
          <Link href="https://www.uber.com/legal/privacy/users">隱私政策</Link>
          <div className={space_40} />
          <Link href="https://www.uber.com/terms">條款</Link>
          <div className={space_40} />
          <Link href="https://help.uber.com/ubereats/article/uber-eats-pricing?nodeId=2adbed88-9822-4690-9529-3061c4821755">價格</Link>
          <div className={space_40} />
          <Link href="https://privacy.uber.com/privacy/california">請勿銷售我的資訊 (加州)</Link>
        </div>
      </div>
      <div className={statement}>
        <div>
          本網站受到 reCAPTCHA 和 Google <Link href="https://policies.google.com/privacy">隱私政策</Link>的保護，且適用<Link href="https://policies.google.com/terms">服務條款</Link>。
        </div>
        <div className={space_40} />
        <div>© 2025 Uber Technologies Inc.</div>
      </div>
    </footer>
  );
};

export default Footer;
