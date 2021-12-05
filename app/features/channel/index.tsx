import { Prop, TChannelItem, TPagesState } from './types';
import Image from 'next/image';
import { Arrow } from 'components';
import ChannelShop from 'features/channel_shop';
import ChannelCategory from 'features/channel_category';
import {
	getOffset,
	getPageDataList,
	getEmphsisPageSize,
	getRegularPageSize,
	isShopsChannel,
	getTotalPage
} from './utils';
import { pagesStateVar } from 'graphql/cache/features';
import { useVar } from 'utils';

import classes from 'styles/features/Channel.module.scss';

const {
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
	space_4,
	space_40,
	rotate_180,
	disableButton
} = classes;
const initialPage: number = 1;
const initialPageState = {
	currentPage: initialPage,
	previousButtonStyle: disableButton,
	nextButtonStyle: ''
};
const CHANNEL_PAGE_OFFSET_SIZE: number = -100;

function Channel({ data }: Prop) {
	const [pages, pagesState] = useVar<TPagesState>(pagesStateVar);

	function _handlePreviousButton(selectedId: string) {
		const page = pagesState[selectedId];

		if (!page || page.currentPage - 1 <= initialPage) {
			pagesStateVar({
				...pagesState,
				[selectedId]: initialPageState
			});
		} else {
			pagesStateVar({
				...pagesState,
				[selectedId]: {
					currentPage: page.currentPage - 1,
					previousButtonStyle: '',
					nextButtonStyle: ''
				}
			});
		};
	};

	function _handleNextButton(selectedId: string, totalPage: number) {
		const page = pagesState[selectedId];

		if (!page) {
			pagesStateVar({
				...pagesState,
				[selectedId]: {
					currentPage: 2,
					previousButtonStyle: '',
					nextButtonStyle: totalPage === 2 ? disableButton : ''
				}
			});
			return;
		};

		if (page.currentPage + 1 < totalPage) {
			pagesStateVar({
				...pagesState,
				[selectedId]: {
					currentPage: page.currentPage + 1,
					previousButtonStyle: '',
					nextButtonStyle: ''
				}
			});
		} else {
			pagesStateVar({
				...pagesState,
				[selectedId]: {
					currentPage: totalPage,
					previousButtonStyle: '',
					nextButtonStyle: disableButton
				}
			});
		};
	};

	function _renderTitleImage(imageSuffix: string) {
		return (
			<div className={titleImage}>
				<Image
					src={`https://${imageSuffix}`}
					layout="fill"
					alt="Emphasis"
				/>
			</div>
		);
	};

	function _renderButtons(uuid: string, totalPage: number) {
		const {
			previousButtonStyle: previousButton,
			nextButtonStyle: nextButton
		} = pages[uuid] ?? initialPageState;

		return (
			<div className={buttonWrapper}>
				<button>查看全部</button>
				<div className={space_40} />
				<div onClick={() => _handlePreviousButton(uuid)}>
					<Arrow appendWrapper={previousButton} />
				</div>
				<div className={space_4} />
				<div onClick={() => _handleNextButton(uuid, totalPage)}>
					<Arrow appendWrapper={`${nextButton} ${rotate_180}`} />
				</div>
			</div>
		);
	};

	function _renderRegularContent(data: TChannelItem[], currentPage: number) {
		if (isShopsChannel(data)) {
			return (
				<ChannelShop
					data={getPageDataList(
						data,
						getRegularPageSize(data)
					)}
					size={getRegularPageSize(data)}
					offset={getOffset(currentPage, CHANNEL_PAGE_OFFSET_SIZE)}
				/>
			);
		};

		return (
			<ChannelCategory
				data={getPageDataList(
					data,
					getRegularPageSize(data)
				)}
				pageOffset={getOffset(currentPage, CHANNEL_PAGE_OFFSET_SIZE)}
			/>
		);
	};

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
				const { currentPage } = pages[uuid] ?? initialPageState;

				if (isEmphasisTitle) {
					const totalPage = getTotalPage(channelItems, getEmphsisPageSize());

					return (
						<div
							className={emphasisWrapper}
							key={uuid}
						>
							<div className={`${titleWrapper} ${emphasisTitle}`}>
								{_renderTitleImage(imageSuffix)}
								<h1>{title}</h1>
								{!subtitle || <span>{subtitle}</span>}
							</div>
							<div className={emphasisContent}>
								<div className={emphasisButton}>
									{_renderButtons(uuid, totalPage)}
								</div>
								<ChannelShop
									data={getPageDataList(
										channelItems,
										getEmphsisPageSize()
									)}
									size={getEmphsisPageSize()}
									offset={getOffset(currentPage, CHANNEL_PAGE_OFFSET_SIZE)}
								/>
							</div>
						</div>
					);
				};

				const totalPage = getTotalPage(
					channelItems,
					getRegularPageSize(channelItems)
				);

				return (
					<div
						className={regularWrapper}
						key={uuid}
					>
						<div className={regularTitle}>
							<div className={titleWrapper}>
								<h1>{title}</h1>
								{!subtitle || <span>{subtitle}</span>}
							</div>
							{_renderButtons(uuid, totalPage)}
						</div>
						{_renderRegularContent(channelItems, currentPage)}
					</div>
				);
			})
		);
	};

	return (
		<div className={wrapper}>
			{_renderChannel()}
		</div>
	);
};

export default Channel;
