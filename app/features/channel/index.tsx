import { Prop } from './types';
import { useState } from 'react';
import Image from 'next/image';
import Arrow from 'components/arrow';

import {
	wrapper,
	emphasisWrapper,
	emphasisTitle,
	titleImage,
	emphasisContent,
	emphasisButton,
	regularWrapper,
	regularTitle,
	titleWrapper,
	buttonWrapper,
	disableButton,
	space_4,
	space_40,
	rotate_180
} from 'styles/features/Channel.module.scss';

function Channel({ channel }: Prop) {
	function _renderTitleImage(imageSuffix: string) {
		return (
			<div className={titleImage}>
				<Image
					src={`https://${imageSuffix}`}
					layout="fill"
					alt="Emphasis"
				/>
			</div>
		)
	}

	function _renderButtons() {
		return (
			<div className={ buttonWrapper }>
				<button>查看全部</button>
				<div className={space_40} />
				<Arrow appendWrapper={disableButton} />
				<div className={space_4} />
				<Arrow appendWrapper={rotate_180} />
			</div>
		)
	}

	function _renderChannel() {
		return (
			channel.map(({
				title,
				subtitle,
				imageSuffix,
				uuid,
				channelItems
			}) => {
				let isEmphasisTitle: boolean = imageSuffix !== '';

				if (isEmphasisTitle) {
					return (
						<div
							className={ emphasisWrapper }
							key={uuid}
						>
							<div className={`${titleWrapper} ${emphasisTitle}`}>
								{ _renderTitleImage(imageSuffix) }
								<h1>{title}</h1>
								{subtitle === '' || <span>{subtitle}</span>}
							</div>
							<div className={ emphasisContent }>
								<div className={ emphasisButton }>
									{ _renderButtons() }
								</div>
								<div>emphasis</div>
							</div>
						</div>
					)
				}

				return (
					<div
						className={ regularWrapper }
						key={uuid}
					>
						<div className={ regularTitle }>
							<div className={ titleWrapper }>
								<h1>{title}</h1>
								{subtitle === '' || <span>{subtitle}</span>}
							</div>
							{ _renderButtons() }
						</div>
						<div>regular</div>
					</div>
				)
			})
		)
	}

	return (
		<div className={ wrapper }>
			{ _renderChannel() }
		</div>
	)
}

export default Channel;
