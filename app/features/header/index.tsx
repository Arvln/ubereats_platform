import { Prop } from './types';
import { TAppendClass } from 'components/button/types';
import { useState } from 'react';
import Link from 'next/link';
import Image from 'next/image';
import { Button } from 'components';

import classes from 'styles/features/Header.module.scss';

const {
  wrapper,
  imageWrapper,
  deliveryOptions,
  deliveryOption,
  deliveryButtonWrapper,
  deliveryButtonContent,
  deliveryButtonSelected,
  locationChoosingWrapper,
  locationButtonWrapper,
  locationButtonContent,
  searchbarWrapper,
  searchbar,
  searchbarShadow,
  cartWrapper,
  cartButtonWrapper,
  cartButtonContent,
  loginWrapper,
  loginButtonWrapper,
  loginButtonContent,
  space_16,
  space_24,
  space_32,
  space_40,
  space_64
} = classes;
const unSelectedButton: TAppendClass = {
  appendWrapper: deliveryButtonWrapper,
  appendContent: deliveryButtonContent
};
const selectedButton: TAppendClass = {
  ...unSelectedButton,
  appendWrapper: `${deliveryButtonWrapper} ${deliveryButtonSelected}`
};
const locationButton: TAppendClass = {
  appendWrapper: locationButtonWrapper,
  appendContent: locationButtonContent
};
const cartButton: TAppendClass = {
  appendWrapper: cartButtonWrapper,
  appendContent: cartButtonContent
};
const loginButton: TAppendClass = {
  appendWrapper: loginButtonWrapper,
  appendContent: loginButtonContent
};

function Header({
  showEntryOptions,
  showDeliveryDetails
}: Prop) {
  const [isDeliveried, setIsDeliveried] = useState<boolean>(true);
  const [searchbarShadowStyle, setSearchbarShadowStyle] = useState<string>('');
  const deliveryButton = isDeliveried ? selectedButton : unSelectedButton;
  const takeOutButton = isDeliveried ? unSelectedButton : selectedButton;
  const searchbarWrapperStyle = `${searchbarWrapper} ${searchbarShadowStyle}`;

  function _handleSearchbarInputFocus() {
    setSearchbarShadowStyle(searchbarShadow);
  };

  function _handleSearchbarInputBlur() {
    setSearchbarShadowStyle('');
  };

  return (
    <header className={wrapper}>
      <div
        className={imageWrapper}
        onClick={() => showEntryOptions()}
      >
        <Image
          src="/images/sidebar.svg"
          width={20}
          height={20}
          alt="Sidebar"
        />
      </div>
      <div className={space_32} />
      <div className={imageWrapper}>
        <Link
          href="/"
        >
          <Image
            src="/images/header_logo.svg"
            width={146}
            height={24}
            alt="Logo"
          />
        </Link>
      </div>
      <div className={space_40} />
      <div className={deliveryOptions}>
        <div
          className={deliveryOption}
          onClick={() => setIsDeliveried(!isDeliveried)}
        >
          <Button
            appendClass={deliveryButton}
            text='外送'
          />
        </div>
        <div
          className={deliveryOption}
          onClick={() => setIsDeliveried(!isDeliveried)}
        >
          <Button
            appendClass={takeOutButton}
            text='外帶'
          />
        </div>
      </div>
      <div className={space_16} />
      <div className={locationChoosingWrapper}>
        <Button
          appendClass={locationButton}
          icon={
            <Image
              src="/images/location.svg"
              width={16}
              height={24}
              alt="Location"
            />
          }
          text={'ABCD . A Better Coffee & Doughnut  •  立刻'}
        />
      </div>
      <div className={space_64} />
      <div className={searchbarWrapperStyle}>
        <label htmlFor="search-input">想吃點什麼</label>
        <div className={searchbar}>
          <Image
            src="/images/search.svg"
            width={24}
            height={24}
            alt="Search"
          />
          <div className={space_16} />
          <input
            type="text"
            placeholder="美食、生鮮雜貨、飲料等"
            onFocus={() => _handleSearchbarInputFocus()}
            onBlur={() => _handleSearchbarInputBlur()}
          />
        </div>
      </div>
      <div className={space_24} />
      <div className={cartWrapper}>
        <Button
          appendClass={cartButton}
          icon={
            <Image
              src="/images/cart.svg"
              width={16}
              height={16}
              alt="Cart" />
          }
          text="購物車 • 0"
        />
      </div>
      <div className={space_24} />
      <div className={loginWrapper}>
        <Button
          appendClass={loginButton}
          text="登入"
        />
      </div>
    </header>
  );
};

export default Header;
