import { Prop, TChannelItem } from './types';
import Image from 'next/image';
import Arrow from 'components/arrow';
import ChannelCategory from 'features/channel_category';
import {
	getPageDataList,
	getEmphsisPageSize,
	getRegularPageSize,
	isShopsChannel
} from './utils';

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
import ChannelShop from 'features/channel_shop';

function Channel({ data }: Prop) {
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

	function _renderRegularContent(data: TChannelItem[]) {
		if (isShopsChannel(data)) {
			return (
				<ChannelShop
					data={getPageDataList(
						data,
						getRegularPageSize(data)
					)}
					pageSize={getRegularPageSize(data)}
				/>
			)
		} else {
			return (
				<ChannelCategory
					data={getPageDataList(
						data,
						getRegularPageSize(data)
					)}
				/>
			)
		}
	}

	function _renderChannel() {
		return (
			data.map(({
				title,
				subtitle,
				imageSuffix,
				uuid,
				channelItems
			}) => {
				const isEmphasisTitle: boolean = imageSuffix !== '';

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
								<ChannelShop
									data={getPageDataList(
										channelItems,
										getEmphsisPageSize()
									)}
									pageSize={getEmphsisPageSize()}
								/>
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
						{ _renderRegularContent(channelItems) }
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
