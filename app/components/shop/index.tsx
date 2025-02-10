import { Prop } from './types';
import { TAppendClass } from 'components/button/types';
import Image from 'next/image';
import Link from 'next/link';
import { Button } from 'components';
import {
  getScore,
  isPickup,
  getPickupDistance,
  getPageSizeWrapper
} from './utils';

import classes from 'styles/components/Shop.module.scss';
import { useLocale } from 'contexts/LocaleContext';

const {
  wrapper,
  storeTitle,
  imageWrapper,
  discountMessage,
  buttonWrapper,
  favorButtonWrapper,
  discountText,
  hideEmpty,
  baseMessage,
  title,
  scoreButtonWrapper,
  scoreText,
  hidden,
  detailMessage,
  detailMessageImage,
  fare,
  costTime,
  distance,
  detailImageWrapper,
  space_12,
  space_16
} = classes;
const SHORTCUT_ICONS_SERVER_HOST = process.env.SHORTCUT_ICONS_SERVER_HOST;
const UTILS_ICONS_SERVER_HOST = process.env.UTILS_ICONS_SERVER_HOST;
const STORE_IMAGE_SERVER_HOST = process.env.STORE_IMAGE_SERVER_HOST;
const withoutCommentScore: string = '0.0';

function Shop({
  data,
  size,
  imageHeight
}: Prop) {
  const { locale } = useLocale();

  function _renderDetailContent(
    cost: number,
    time: number,
    uuid: string
  ) {
    const isPickupByCustomer: boolean = isPickup(cost);

    if (isPickupByCustomer)
      return (
        <>
          <div className={costTime} data-testid={`cost-time-${uuid}`}>
            <span>
              {time}–{time + 10}分鐘
            </span>
          </div>
          <span> • </span>
          <div className={distance} data-testid={`distance-${uuid}`}>
            <span>{getPickupDistance(cost)}公里</span>
          </div>
        </>
      );
    else
      return (
        <>
          <span> • </span>
          <div className={fare} data-testid={`fare-${uuid}`}>
            <span>{cost}TWD 費用</span>
          </div>
          <span> • </span>
          <div className={costTime} data-testid={`cost-time-${uuid}`}>
            <span>
              {time}–{time + 10}分鐘
            </span>
          </div>
        </>
      )
  }

  function _renderScoreButton(score: number, uuid: string) {
    const isCarefullySelected: boolean = score === 100;
    const isComment: boolean = getScore(score) !== withoutCommentScore;
    const scoreButton: TAppendClass = {
      appendWrapper: isComment ? scoreButtonWrapper : hidden,
      appendContent: scoreText
    };

    if (isCarefullySelected)
      return (
        <div className={scoreButtonWrapper} data-testid={`score-button-${uuid}`}>
          <Image
            src={`https://${SHORTCUT_ICONS_SERVER_HOST}/eatsfeed/other_icons/top_eats.png`}
            fill
            alt="Carefully Selected"
          />
        </div>
      );
    else
      return (
        <Button
          appendClass={scoreButton}
          text={getScore(score)}
          data-testid={`score-button-${uuid}`}
        />
      );
  }


  return (
    <>
      {
        data.map(({
          name,
          deliveryCost,
          shortestDeliveryTime,
          score,
          discountLabel,
          imageSuffix,
          uuid
        }) => {
          const pageSizeWrapper: string | void = getPageSizeWrapper(size);
          const shopWrapper =
            pageSizeWrapper ? `${wrapper} ${pageSizeWrapper}` : wrapper;
          const hideEmptyElement: string = !discountLabel ? hideEmpty : '';
          const favorButton: TAppendClass = {
            appendWrapper: favorButtonWrapper,
            appendContent: ''
          };

          return (
            <li
              className={shopWrapper}
              key={uuid}
              data-testid={`shop-item-${uuid}`}
            >
              <Link href={`/${locale}/store/${name}/${uuid}`}>
                <h3 className={storeTitle} data-testid={`store-title-${uuid}`}>{name}</h3>
                <div className={`${imageWrapper} ${imageHeight}`} data-testid={`image-wrapper-${uuid}`}>
                  <Image
                    src={`https://${STORE_IMAGE_SERVER_HOST}/${imageSuffix}`}
                    fill
                    sizes="25vw"
                    alt="Shop"
                    style={{ objectFit: 'cover' }}
                  />
                  <div className={discountMessage} data-testid={`discount-message-${uuid}`}>
                    <span
                      className={`${hideEmptyElement} ${discountText}`}
                      data-testid={`discount-text-${uuid}`}>
                      {discountLabel}
                    </span>
                    <div className={buttonWrapper} data-testid={`button-wrapper-${uuid}`}>
                      <div className={space_16} />
                      <Button
                        appendClass={favorButton}
                        icon={
                          <Image
                            src="/images/favor_white.svg"
                            width="20"
                            height="20"
                            alt="Favor"
                          />
                        }
                        data-testid={`favor-button-${uuid}`}
                      />
                      <div className={space_12} />
                    </div>
                  </div>
                </div>
                <div className={baseMessage} data-testid={`base-message-${uuid}`}>
                  <div className={title} data-testid={`base-message-title-${uuid}`}>{name}</div>
                  {_renderScoreButton(score, uuid)}
                </div>
                <div className={detailMessage} data-testid={`detail-message-${uuid}`}>
                  <div className={detailImageWrapper} data-testid={`detail-image-wrapper-${uuid}`}>
                    <div className={detailMessageImage} data-testid={`detail-message-image-${uuid}`}>
                      <Image
                        src={`https://${UTILS_ICONS_SERVER_HOST}/ticket@3x.png`}
                        fill
                        alt="Ticket"
                      />
                    </div>
                  </div>
                  {_renderDetailContent(deliveryCost, shortestDeliveryTime, uuid)}
                </div>
              </Link>
            </li>
          );
        })
      }
    </>
  )
}

export default Shop;
