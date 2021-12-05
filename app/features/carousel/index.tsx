import { Prop } from './types';
import { useEffect, useState } from 'react';
import Link from 'next/link';
import Image from 'next/image';
import { Arrow } from 'components';
import {
	getRenderData,
	getRightStartPoint
} from './utils';
import { horizontalOffsetVar } from 'graphql/cache/features'
import { useVar } from 'utils';

import classes from 'styles/features/Carousel.module.scss';

const {
	wrapper,
	content,
	smoothTransition,
	clearTransition,
	advertiseWrapper,
	advertiseItem,
	itemWrapper,
	space_4,
	rightButtonWrapper
} = classes;

const ADVERTISE_IMAGE_SERVER_HOST = process.env.ADVERTISE_IMAGE_SERVER_HOST;
const offsetPerClick: number = 100;
const leftBoundaryValue: number = -100;
const rightBoundaryValue: number = -433.333;
const leftStratPoint: number = -133.333;

function Carousel({ data }: Prop) {
	const [horizontalOffset] = useVar<number>(horizontalOffsetVar);
	const [transition, setTransition] = useState<string>(smoothTransition);

	useEffect(() => {
		if (horizontalOffset <= rightBoundaryValue) {
			horizontalOffsetVar(leftStratPoint);
			setTransition(clearTransition);
		}

		if (horizontalOffset > leftBoundaryValue) {
			horizontalOffsetVar(getRightStartPoint(horizontalOffset));
			setTransition(clearTransition);
		}

	}, [horizontalOffset]);

	function _handlePreviousButton(): void {
		if (horizontalOffset <= leftBoundaryValue) {
			horizontalOffsetVar(horizontalOffset + offsetPerClick);
			setTransition(smoothTransition);
		}
	}

	function _handleNextButton(): void {
		if (horizontalOffset > rightBoundaryValue) {
			horizontalOffsetVar(horizontalOffset - offsetPerClick);
			setTransition(smoothTransition);
		}
	}

	function _renderItems() {
		data = getRenderData(data);

		return (
			data.map(({
				imageSuffix,
				uuid
			}, index) => {
				const ariaHidden: boolean | undefined =
					index < 3 || index > data.length - 6
						? true
						: undefined;

				return (
					<li
						key={index}
						aria-hidden={ariaHidden}
						className={advertiseItem}
					>
						<div className={itemWrapper}>
							<Link href={`/marketing/${uuid}`}>
								<a>
									<Image
										src={`https://${ADVERTISE_IMAGE_SERVER_HOST}/${imageSuffix}`}
										layout="fill"
										alt={imageSuffix}
									/>
								</a>
							</Link>
						</div>
					</li>
				)
			})
		);
	};

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
};

export default Carousel;
