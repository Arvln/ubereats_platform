import { Prop } from './types';
import { TGood } from 'types/pages/store';
import { useContext } from 'react';
import Image from 'next/image';
import { getDiscountPrice, isFreeGift } from './utils';
import { FormContext } from 'features/layout';
import OrderForm from '../order_form';

import classes from 'styles/features/store/Menu.module.scss';

const {
  wrapper,
  contentWrapper,
  title,
  content,
  goodWrapper,
  goodItem,
  emphasis,
  emphasisItem,
  detail,
  goodPrice,
  emphasisPrice,
  origin,
  discount,
  introduction,
  imageWrapper,
  image
} = classes;
const STORE_IMAGE_SERVER_HOST = process.env.STORE_IMAGE_SERVER_HOST;

function Menu({ data }: Prop) {
  const handleForm = useContext(FormContext);

  function _renderImage(name: string, suffix?: string) {
    if (!suffix) return;

    return (
      <div className={imageWrapper}>
        <Image
          src={`https://${STORE_IMAGE_SERVER_HOST}/${suffix}`}
          className={image}
          layout="fill"
          objectFit="cover"
          alt={name}
        />
      </div>
    );
  };

  function _renderDetails(
    text: string | number,
    style?: string,
    label?: string
  ) {
    if (!text) return;

    const discountPrice = getDiscountPrice(text, label);

    if (typeof (text) === 'number')
      text = `$${text}`;
    if (discountPrice) {
      return (
        <div className={style}>
          <span className={discount}>{discountPrice}</span>
          <span className={origin}>{text}</span>
        </div>
      );
    };

    return (
      <div className={style}>
        <span>{text}</span>
      </div>
    );
  };

  function _handleOrder(label: string, good: TGood) {
    const { price } = good;

    if (!price || isFreeGift(label)) return;

    return () => handleForm(<OrderForm data={good} />);
  }

  function _renderGoods(label: string, goods: TGood[]) {
    return (
      goods.map(good => {
        const {
          name,
          price,
          discription,
          imageSuffix,
          isEmphasis,
          uuid
        } = good;
        const wrapper = isEmphasis ? `${goodWrapper} ${emphasis}` : goodWrapper;
        const itemWrapper = imageSuffix ? `${goodItem} ${emphasisItem}` : goodItem;
        const priceStyle = isEmphasis ? `${goodPrice} ${emphasisPrice}` : goodPrice;

        return (
          <li
            className={wrapper}
            onClick={_handleOrder(label, good)}
            key={uuid}
            data-testid={`good-detail-${uuid}`}
          >
            <div className={itemWrapper}>
              {_renderImage(name, imageSuffix)}
              <div className={detail}>
                {_renderDetails(name)}
                {_renderDetails(price, priceStyle, label)}
                {isEmphasis && _renderDetails(discription, introduction)}
              </div>
            </div>
          </li>
        );
      })
    );
  };

  function _renderContent() {
    const wrapper = contentWrapper;

    return (
      data.map(({
        label,
        items
      }) => (
        <li
          className={wrapper}
          key={label}
        >
          <div>
            <h1 className={title}>{label}</h1>
          </div>
          <ul className={content}>
            {_renderGoods(label, items)}
          </ul>
        </li>
      ))
    );
  };

  return (
    <div className={wrapper}>
      {_renderContent()}
    </div>
  );
};

export default Menu;
