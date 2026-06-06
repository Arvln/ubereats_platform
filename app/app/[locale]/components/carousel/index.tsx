"use client";

import { useQuery } from "@tanstack/react-query";
import { useEffect, useState } from "react";
import { Link } from "i18n/navigation";
import Image from "next/image";
import { blurDataURL } from "lib/image-placeholder";
import { Arrow } from "components";
import { getRenderData, getRightStartPoint } from "./utils";
import { homePageQueryOptions } from "../../queries";

import classes from "styles/features/Carousel.module.scss";

const {
  wrapper,
  content,
  smoothTransition,
  clearTransition,
  advertiseWrapper,
  advertiseItem,
  itemWrapper,
  space_4,
  rightButtonWrapper,
} = classes;

const ADVERTISE_IMAGE_SERVER_HOST = process.env.ADVERTISE_IMAGE_SERVER_HOST;
const offsetPerClick: number = 100;
const leftBoundaryValue: number = -100;
const rightBoundaryValue: number = -433.333;
const leftStratPoint: number = -133.333;

function Carousel() {
  const { data: carousel = [] } = useQuery({
    ...homePageQueryOptions,
    select: (pageData) => pageData.carousel,
  });
  const [horizontalOffset, setHorizontalOffset] = useState(-100);
  const [transition, setTransition] = useState<string>(smoothTransition);

  useEffect(() => {
    if (horizontalOffset <= rightBoundaryValue) {
      setHorizontalOffset(leftStratPoint);
      setTransition(clearTransition);
    }

    if (horizontalOffset > leftBoundaryValue) {
      setHorizontalOffset(getRightStartPoint(horizontalOffset));
      setTransition(clearTransition);
    }
  }, [horizontalOffset]);

  function _handlePreviousButton(): void {
    if (horizontalOffset <= leftBoundaryValue) {
      setHorizontalOffset(horizontalOffset + offsetPerClick);
      setTransition(smoothTransition);
    }
  }

  function _handleNextButton(): void {
    if (horizontalOffset > rightBoundaryValue) {
      setHorizontalOffset(horizontalOffset - offsetPerClick);
      setTransition(smoothTransition);
    }
  }

  function _renderItems() {
    const items = getRenderData(carousel);

    return items.map(({ imageSuffix, uuid }, index) => {
      const ariaHidden: boolean | undefined =
        index < 3 || index > items.length - 6 ? true : undefined;

      return (
        <li key={index} aria-hidden={ariaHidden} className={advertiseItem}>
          <div className={itemWrapper}>
            <Link href={`/marketing/${uuid}`}>
              <Image
                src={`https://${ADVERTISE_IMAGE_SERVER_HOST}/${imageSuffix}`}
                fill
                sizes="(max-width: 768px) 100vw, 25vw"
                placeholder="blur"
                blurDataURL={blurDataURL}
                alt={imageSuffix}
              />
            </Link>
          </div>
        </li>
      );
    });
  }

  return (
    <div className={wrapper}>
      <div onClick={_handlePreviousButton}>
        <Arrow />
      </div>
      <div className={space_4} />
      <div className={content}>
        <ol
          className={`${advertiseWrapper} ${transition}`}
          style={{ transform: `translateX(${horizontalOffset}%)` }}
        >
          {_renderItems()}
        </ol>
      </div>
      <div className={space_4} />
      <div onClick={_handleNextButton}>
        <Arrow appendWrapper={rightButtonWrapper} />
      </div>
    </div>
  );
}

export default Carousel;
