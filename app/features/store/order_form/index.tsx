import { Prop } from './types';
import { TAppendClass } from 'components/button/types';
import { Button } from 'components';
import { useState } from 'react';
import Image from 'next/image';

import classes from 'styles/features/store/OrderForm.module.scss';

const {
  wrapper,
  navbar,
  hidden,
  imageWrapper,
  information,
  title,
  introduction,
  spicyWrapper,
  spicyImage,
  doveGreyDivider,
  invoice,
  lightGreyDivider,
  placeOrder,
  operation,
  amount,
  buttonWrapper,
  status,
  totalAmount,
  totalPrice,
  space_4,
  space_24,
  height_48
} = classes;
const STORE_IMAGE_SERVER_HOST = process.env.STORE_IMAGE_SERVER_HOST;
const SPICY_ICON_SERVER_HOST = process.env.SPICY_ICON_SERVER_HOST;
const button: TAppendClass = {
  appendWrapper: buttonWrapper,
  appendContent: ''
};

function OrderForm({ data }: Prop) {
  const [purchaseAmount, setPurchaseAmount] = useState<Record<string, number>>({});
  const {
    name,
    price,
    discription,
    imageSuffix,
    spicyLevel
  } = data;
  const orderAmount: number = purchaseAmount[name] ?? 1;

  function _renderImage(suffix: string) {
    if (!suffix) return <div className={height_48} />;

    return (
      <div className={imageWrapper}>
        <Image
          src={`https://${STORE_IMAGE_SERVER_HOST}/${imageSuffix}`}
          layout="fill"
          alt="Good"
        />
      </div>
    );
  };

  function _renderSpicyInformation(level: string) {
    if (!level) return;

    const wrapper = spicyWrapper;
    const image = spicyImage;

    return (
      <div className={wrapper}>
        <div className={image}>
          <Image
            src={`https://${SPICY_ICON_SERVER_HOST}/badge_check@3x.png`}
            layout="fill"
            alt="Spicy Level"
          />
        </div>
        <div className={space_4} />
        {spicyLevel}
      </div>
    );
  };

  function _handleDecrementButton() {
    if (orderAmount <= 1) return;

    setPurchaseAmount({
      ...purchaseAmount,
      [name]: orderAmount - 1
    });
  };

  function _handleIncrementButton() {
    setPurchaseAmount({
      ...purchaseAmount,
      [name]: orderAmount + 1
    })
  }

  return (
    <div
      className={wrapper}
      onClick={event => event.stopPropagation()}
    >
      <div className={hidden}>
        <span>{name}</span>
      </div>
      {_renderImage(imageSuffix)}
      <div className={information}>
        <h1 className={title}>{name}</h1>
        <div className={introduction}>
          <span>{discription}</span>
        </div>
        {_renderSpicyInformation(spicyLevel)}
      </div>
      <hr className={doveGreyDivider} />
      <div className={invoice}>
        <span>
          [本店免開統一發票] (上開肉品資訊是由我們所合作之商家合作夥伴所提供。如對上開資訊有任何疑問，請直接與商家合作夥伴聯繫)
        </span>
      </div>
      <hr className={lightGreyDivider} />
      <div className={placeOrder}>
        <div className={operation}>
          <div onClick={() => _handleDecrementButton()}>
            <Button
              appendClass={button}
              icon={
                <Image
                  src="/images/decrement.svg"
                  width="24"
                  height="24"
                  alt="Decrement"
                />
              }
            />
          </div>
          <div className={amount} data-testid="order-amount">{orderAmount}</div>
          <div onClick={() => _handleIncrementButton()}>
            <Button
              appendClass={button}
              icon={
                <Image
                  src="/images/increment.svg"
                  width="24"
                  height="24"
                  alt="Increment"
                />
              }
            />
          </div>
        </div>
        <div className={space_24} />
        <button className={status} data-testid="add-to-cart">
          <div className={totalAmount}>{`新增 ${orderAmount} 項商品至訂單`}</div>
          <div className={totalPrice}>${price * orderAmount}</div>
        </button>
      </div>
    </div>
  )
}

export default OrderForm
