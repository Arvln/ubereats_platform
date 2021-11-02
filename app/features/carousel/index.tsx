import { Prop } from './types';
import { useState } from 'react';
import Link from 'next/link';
import Image from 'next/image';
import Arrow from 'components/arrow';

import {
	wrapper,
	content,
	advertiseWrapper,
	advertiseItem,
	itemWrapper,
	space_4,
	rightButtonWrapper
} from 'styles/features/Carousel.module.scss';

const ADVERTISE_IMAGE_SERVER_HOST = process.env.ADVERTISE_IMAGE_SERVER_HOST;
const originOffset: number = -66.6666;
const offsetPerClick: number = 33.3333;

function Carousel({ carousel }: Prop) {
	const [horizontalOffset, setHorizontalOffset] = useState<number>(originOffset);

	function _handlePreviousButton(): void {
		if (horizontalOffset >= 0)
			setHorizontalOffset(originOffset)
		else
			setHorizontalOffset(horizontalOffset + offsetPerClick)
	}

	function _handleNextButton(): void {
		if (horizontalOffset <= offsetPerClick * (3 - carousel.length))
			setHorizontalOffset(originOffset)
		else
			setHorizontalOffset(horizontalOffset - offsetPerClick)
	}

	function _renderItems(): JSX.Element[] {
		return (
			carousel.map(({
				imageSuffix,
				uuid
			}) => (
				<li
					key={uuid}
					className={ advertiseItem }
				>
					<div className={ itemWrapper }>
						<Link href={`/carousel/${uuid}`}>
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
			))
		)
	}

	return (
		<div className={ wrapper }>
			<div onClick={() => _handlePreviousButton()}>
				<Arrow />
			</div>
			<div className={ space_4 } />
			<div className={ content }>
				<ol
					className={ advertiseWrapper }
					style={{ transform: `translateX(${horizontalOffset}%)` }}
				>
					{ _renderItems() }
				</ol>
			</div>
			<div className={ space_4 } />
			<div onClick={() => _handleNextButton()}>
				<Arrow appendWrapper={ rightButtonWrapper } />
			</div>
		</div>
	)
}

export default Carousel;
