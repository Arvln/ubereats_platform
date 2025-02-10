import { Prop, TConditionsState } from './types';
import {
  ConditionsTypes,
  ClassificationTypes,
  ClassificationsTypes,
  PriceLevelTypes,
  DeliveryCostLimitTypes,
  DeliveryRestrictionTypes,
  DeliveryRestrictionsTypes
} from 'enums/features/restrict_search';
import { TAppendClass } from 'components/button/types';
import { useState, useRef } from 'react';
import Image from 'next/image';
import { Button } from 'components';
import { conditionsStateVar } from 'graphql/cache/features';
import { useVar } from 'utils';

import classes from 'styles/features/RestrictSearch.module.scss';
import { useTranslations } from 'next-intl';

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
const {
  CLASSIFICATION,
  PRICE_RANGE,
  DELIVERY_COST_LIMITATION,
  DIETARY_RESTRICTION
} = ConditionsTypes;
const {
  RECOMMEND,
  POPULAR,
  SCORE,
  DELIVERY_TIME
} = ClassificationTypes;
const {
  EXTREMELY_LOW,
  LOW,
  MIDDLE,
  HIGH
} = PriceLevelTypes;
const {
  LOWEST_FEE,
  LOW_FEE,
  MODERATE_FEE,
  HIGHER_FEE
} = DeliveryCostLimitTypes;
const {
  VEGETABLE,
  VEGAN,
  GLUTEN_FREE,
  NO_ALLERGY
} = DeliveryRestrictionTypes;

function RestrictSearch({ isCuisines }: Prop) {
  const t = useTranslations();
  const [conditions, conditionsState] = useVar<TConditionsState>(conditionsStateVar);
  const [classificationOption, setClassificationOption] = useState<number>(RECOMMEND);
  const [deliveryCostInputValue, setDeliveryCostInputValue] = useState<number>(HIGHER_FEE);
  const deliveryCostInput = useRef<HTMLInputElement | null>(null);

  function _handleButton(title: string) {
    const conditionState = conditionsState[title];

    if (!conditionState) {
      conditionsStateVar({
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

    conditionsStateVar({
      ...conditionsState,
      [title]: {
        rotate: !rotate ? rotate_180 : '',
        conditionContentWrapper:
          conditionContentWrapper === hidden ? conditionContent : hidden
      }
    });
  };

  function _renderClassificationContent() {
    const classifications: number[] = [RECOMMEND, POPULAR, SCORE, DELIVERY_TIME];

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
    const priceRanges: string[] = [EXTREMELY_LOW, LOW, MIDDLE, HIGH];
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
    const secondDivider: string = `${deliveryCostOption} ${deliveryCostInputValue !== MODERATE_FEE ? divider : ''}`;

    return (
      <div className={deliveryCostContent}>
        <div className={deliveryCostOptions}>
          <div
            className={deliveryCostOption}
            onClick={() => setDeliveryCostInputValue(LOWEST_FEE)}
          >
            {t('restrict-search.lowest')}
          </div>
          <div
            className={firstDivider}
            onClick={() => setDeliveryCostInputValue(LOW_FEE)}
          >
            {t('restrict-search.low')}
          </div>
          <div
            className={secondDivider}
            onClick={() => setDeliveryCostInputValue(MODERATE_FEE)}
          >
            {t('restrict-search.moderate')}
          </div>
          <div
            className={deliveryCostOption}
            onClick={() => setDeliveryCostInputValue(HIGHER_FEE)}
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
    const deliveryRestrictions: number[] = [VEGETABLE, VEGAN, GLUTEN_FREE, NO_ALLERGY];
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
    if (condition === DIETARY_RESTRICTION && !isCuisines) return;

    const initialConditionsState = {
      rotate: rotate_180,
      conditionContentWrapper: conditionContent
    };
    const {
      rotate,
      conditionContentWrapper
    } = conditions[condition] ?? initialConditionsState;
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
              layout="fill"
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
              CLASSIFICATION,
              _renderClassificationContent()
            )
          }
          {
            _renderCondition(
              PRICE_RANGE,
              _renderPriceRange()
            )
          }
          {
            _renderCondition(
              DELIVERY_COST_LIMITATION,
              _renderDeliveryCostLimitation()
            )
          }
          {
            _renderCondition(
              DIETARY_RESTRICTION,
              _renderDietaryRestriction()
            )
          }
        </div>
      </aside>
    </div>
  );
};

export default RestrictSearch;
