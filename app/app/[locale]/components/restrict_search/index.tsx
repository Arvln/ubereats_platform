'use client';

import { Prop, TConditionsState } from './types';
import { TAppendClass } from 'components/button/types';
import { useState, useRef } from 'react';
import Image from 'next/image';
import { Button } from 'components';
import classes from 'styles/features/RestrictSearch.module.scss';
import { useTranslations } from 'next-intl';

enum ConditionsTypes {
  CLASSIFICATION = 'restrict-search.categories',
  PRICE_RANGE = 'restrict-search.price-range',
  DELIVERY_COST_LIMITATION = 'restrict-search.maximum-delivery-fee',
  DIETARY_RESTRICTION = 'restrict-search.dietary-restrictions'
};

enum ClassificationTypes {
  RECOMMEND = 0,
  POPULAR = 1,
  SCORE = 2,
  DELIVERY_TIME = 3
};

enum ClassificationsTypes {
  RECOMMEND = 'restrict-search.personalized-recommended-dishes',
  POPULAR = 'restrict-search.popular-dishes',
  SCORE = 'restrict-search.rating',
  DELIVERY_TIME = 'restrict-search.delivery-time'
};

enum PriceLevelTypes {
  EXTREMELY_LOW = '$',
  LOW = '$$',
  MIDDLE = '$$$',
  HIGH = '$$$$'
};

enum DeliveryCostLimitTypes {
  LOWEST_FEE = 0,
  LOW_FEE = 1,
  MODERATE_FEE = 2,
  HIGHER_FEE = 3,
};

enum DeliveryRestrictionTypes {
  VEGETABLE = 0,
  VEGAN = 1,
  GLUTEN_FREE = 2,
  NO_ALLERGY = 3
};

enum DeliveryRestrictionsTypes {
  VEGETABLE = 'restrict-search.vegetarian-dishes',
  VEGAN = 'restrict-search.vegan-dishes',
  GLUTEN_FREE = 'restrict-search.gluten-free-dishes',
  NO_ALLERGY = 'restrict-search.allergy-friendly'
};

const {
  wrapper,
  searchWrapper,
  content,
  title,
  conditionWrapper,
  conditionTitle,
  optionTitle,
  buttonWrapper,
  conditionContent,
  hidden,
  classificationContent,
  optionContentLabel,
  selectedLabel,
  priceContent,
  rangeButtonWrapper,
  rangeButtonContentWrapper,
  deliveryCostContent,
  deliveryCostOptions,
  deliveryCostOption,
  divider,
  slider,
  dietaryContent,
  dietaryButtonWrapper,
  dietaryButtonContentWrapper,
  space_16,
  rotate_180
} = classes;

function RestrictSearch({ isCuisines }: Prop) {
  const t = useTranslations();
  const [conditionsState, setConditionsState] = useState<TConditionsState>({});
  const [classificationOption, setClassificationOption] = useState<number>(ClassificationTypes.RECOMMEND);
  const [deliveryCostInputValue, setDeliveryCostInputValue] = useState<number>(DeliveryCostLimitTypes.HIGHER_FEE);
  const deliveryCostInput = useRef<HTMLInputElement | null>(null);

  function _handleButton(title: string) {
    const conditionState = conditionsState[title];

    if (!conditionState) {
      setConditionsState({
        ...conditionsState,
        [title]: {
          rotate: '',
          conditionContentWrapper: hidden
        }
      });
      return;
    };

    const {
      rotate,
      conditionContentWrapper
    } = conditionState;

    setConditionsState({
      ...conditionsState,
      [title]: {
        rotate: !rotate ? rotate_180 : '',
        conditionContentWrapper:
          conditionContentWrapper === hidden ? conditionContent : hidden
      }
    });
  };

  function _renderClassificationContent() {
    const classifications: number[] = [
      ClassificationTypes.RECOMMEND,
      ClassificationTypes.POPULAR,
      ClassificationTypes.SCORE,
      ClassificationTypes.DELIVERY_TIME
    ];

    return (
      classifications.map(classification => {
        const isSelected: boolean = classification === classificationOption;
        const labelStyle =
          isSelected ? `${optionContentLabel} ${selectedLabel}` : optionContentLabel;
        const key: string = ClassificationTypes[classification];
        const title: string = (ClassificationsTypes as any)[key];

        return (
          <div
            className={classificationContent}
            key={key}
          >
            <input
              type="radio"
              id={key}
              name={key}
              value={title}
              defaultChecked={isSelected}
              onClick={() => setClassificationOption(classification)}
            />
            <label
              className={labelStyle}
              htmlFor={key}
            >
              <div className={space_16}></div>
              <span>{` ${t(title)}`}</span>
            </label>
          </div>
        );
      })
    );
  };

  function _renderPriceRange() {
    const priceRanges: string[] = [
      PriceLevelTypes.EXTREMELY_LOW,
      PriceLevelTypes.LOW,
      PriceLevelTypes.MIDDLE,
      PriceLevelTypes.HIGH
    ];
    const priceRangeButton: TAppendClass = {
      appendWrapper: rangeButtonWrapper,
      appendContent: rangeButtonContentWrapper
    };

    return (
      <div className={priceContent}>
        {
          priceRanges.map(priceRange => (
            <Button
              key={priceRange}
              appendClass={priceRangeButton}
              text={priceRange}
            />
          ))
        }
      </div>
    );
  };

  function _handleDeliveryCostInput(element: HTMLInputElement | null) {
    if (!element) return;
    setDeliveryCostInputValue(parseInt(element.value));
  };

  function _renderDeliveryCostLimitation() {
    const firstDivider: string = `${deliveryCostOption} ${divider}`;
    const secondDivider: string = `${deliveryCostOption} ${deliveryCostInputValue !== DeliveryCostLimitTypes.MODERATE_FEE ? divider : ''}`;

    return (
      <div className={deliveryCostContent}>
        <div className={deliveryCostOptions}>
          <div
            className={deliveryCostOption}
            onClick={() => setDeliveryCostInputValue(DeliveryCostLimitTypes.LOWEST_FEE)}
          >
            {t('restrict-search.lowest')}
          </div>
          <div
            className={firstDivider}
            onClick={() => setDeliveryCostInputValue(DeliveryCostLimitTypes.LOW_FEE)}
          >
            {t('restrict-search.low')}
          </div>
          <div
            className={secondDivider}
            onClick={() => setDeliveryCostInputValue(DeliveryCostLimitTypes.MODERATE_FEE)}
          >
            {t('restrict-search.moderate')}
          </div>
          <div
            className={deliveryCostOption}
            onClick={() => setDeliveryCostInputValue(DeliveryCostLimitTypes.HIGHER_FEE)}
          >
            {t('restrict-search.higher')}
          </div>
        </div>
        <input
          ref={deliveryCostInput}
          type="range"
          className={slider}
          max="3"
          value={deliveryCostInputValue}
          onInput={() => _handleDeliveryCostInput(deliveryCostInput.current)}
        />
      </div>
    );
  };

  function _renderDietaryRestriction(): JSX.Element {
    const deliveryRestrictions: number[] = [
      DeliveryRestrictionTypes.VEGETABLE,
      DeliveryRestrictionTypes.VEGAN,
      DeliveryRestrictionTypes.GLUTEN_FREE,
      DeliveryRestrictionTypes.NO_ALLERGY
    ];
    const deliveryRestrictionButton: TAppendClass = {
      appendWrapper: dietaryButtonWrapper,
      appendContent: dietaryButtonContentWrapper
    };

    return (
      <div className={dietaryContent}>
        {
          deliveryRestrictions.map(deliveryRestriction => {
            const key: string = DeliveryRestrictionTypes[deliveryRestriction];
            const title: string = (DeliveryRestrictionsTypes as any)[key];

            return (
              <Button
                key={key}
                appendClass={deliveryRestrictionButton}
                icon={
                  <Image
                    src={`/images/${key.toLocaleLowerCase()}.svg`}
                    width="20"
                    height="20"
                    alt={key}
                  />
                }
                text={` ${t(title)}`}
              />
            )
          })
        }
      </div>
    );
  };

  function _renderCondition(
    condition: string,
    content: JSX.Element | JSX.Element[]
  ) {
    if (condition === ConditionsTypes.DIETARY_RESTRICTION && !isCuisines) return;

    const initialConditionsState = {
      rotate: rotate_180,
      conditionContentWrapper: conditionContent
    };
    const {
      rotate,
      conditionContentWrapper
    } = conditionsState[condition] ?? initialConditionsState;
    const button = `${buttonWrapper} ${rotate}`;

    return (
      <div className={conditionWrapper}>
        <div
          className={conditionTitle}
        >
          <div className={optionTitle}>{t(condition)}</div>
          <div
            className={button}
            onClick={() => _handleButton(condition)}
          >
            <Image
              src="/images/dropdown.svg"
              fill
              sizes="24px"
              alt="Dropdown"
            />
          </div>
        </div>
        <div className={conditionContentWrapper}>
          {content}
        </div>
      </div>
    );
  };

  return (
    <div className={wrapper}>
      <aside className={searchWrapper}>
        <div className={content}>
          <div className={title}>
            <h1>{t('restrict-search.all-restaurant-locations')}</h1>
          </div>
          {
            _renderCondition(
              ConditionsTypes.CLASSIFICATION,
              _renderClassificationContent()
            )
          }
          {
            _renderCondition(
              ConditionsTypes.PRICE_RANGE,
              _renderPriceRange()
            )
          }
          {
            _renderCondition(
              ConditionsTypes.DELIVERY_COST_LIMITATION,
              _renderDeliveryCostLimitation()
            )
          }
          {
            _renderCondition(
              ConditionsTypes.DIETARY_RESTRICTION,
              _renderDietaryRestriction()
            )
          }
        </div>
      </aside>
    </div>
  );
};

export default RestrictSearch;
