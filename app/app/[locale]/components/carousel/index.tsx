"use client";

import { useQuery } from "@tanstack/react-query";
import { useRef, useState, type TransitionEvent } from "react";
import { Link } from "i18n/navigation";
import Image from "next/image";
import { blurDataURL } from "lib/image-placeholder";
import { Arrow } from "components";
import { GROUP_SIZE, getRenderWindow, wrapIndex } from "./utils";
import { homePageQueryOptions } from "../../queries";

import classes from "@/styles/features/Carousel.module.scss";

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

/* The window holds three side-by-side groups (previous | current | next), so
 * the track is 300% of the viewport wide. -100% rests on the current group;
 * sliding ±100% reveals the next/previous group before we snap back. */
const restingOffset: number = -100;
const nextOffset: number = -200;
const previousOffset: number = 0;

type SlideDirection = "next" | "previous";

function Carousel() {
  const { data: carousel = [] } = useQuery({
    ...homePageQueryOptions,
    select: (pageData) => pageData.carousel,
  });

  const [currentIndex, setCurrentIndex] = useState(0);
  const [horizontalOffset, setHorizontalOffset] = useState(restingOffset);
  const [transition, setTransition] = useState<string>(smoothTransition);

  const isAnimating = useRef(false);
  const pendingDirection = useRef<SlideDirection | null>(null);

  const items = getRenderWindow(carousel, currentIndex);

  function _slide(direction: SlideDirection): void {
    if (isAnimating.current || carousel.length === 0) return;

    isAnimating.current = true;
    pendingDirection.current = direction;
    setTransition(smoothTransition);
    setHorizontalOffset(direction === "next" ? nextOffset : previousOffset);
  }

  function _handlePreviousButton(): void {
    _slide("previous");
  }

  function _handleNextButton(): void {
    _slide("next");
  }

  /* Once the slide animation finishes, advance the logical index by one group
   * and snap the track back to its resting offset without a transition. The
   * group we just slid to now occupies the current slots showing the same
   * images at the same position, so the reset is seamless and infinite. */
  function _handleTransitionEnd(
    event: TransitionEvent<HTMLOListElement>,
  ): void {
    if (event.propertyName !== "transform") return;

    const direction = pendingDirection.current;
    if (!direction) return;

    setCurrentIndex((index) =>
      wrapIndex(
        index + (direction === "next" ? GROUP_SIZE : -GROUP_SIZE),
        carousel.length,
      ),
    );
    setTransition(clearTransition);
    setHorizontalOffset(restingOffset);

    pendingDirection.current = null;
    isAnimating.current = false;
  }

  function _renderItems() {
    return items.map(({ imageSuffix, uuid, slot, dataIndex }) => {
      // Only the middle group is the live, visible content; flank groups are
      // off-screen look-ahead/look-behind buffers.
      const ariaHidden: boolean | undefined =
        slot < GROUP_SIZE || slot >= GROUP_SIZE * 2 ? true : undefined;

      return (
        <li key={dataIndex} aria-hidden={ariaHidden} className={advertiseItem}>
          <div className={itemWrapper}>
            <Link
              href={`/marketing/${uuid}`}
              className="absolute inset-0 block"
            >
              <Image
                src={`https://${ADVERTISE_IMAGE_SERVER_HOST}/${imageSuffix}`}
                fill
                sizes="(max-width: 768px) 100vw, 25vw"
                priority={slot >= GROUP_SIZE && slot < GROUP_SIZE * 2}
                loading={
                  slot >= GROUP_SIZE && slot < GROUP_SIZE * 2 ? "eager" : "lazy"
                }
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
          onTransitionEnd={_handleTransitionEnd}
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
