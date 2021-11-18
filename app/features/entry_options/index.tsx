import { TAppendClass } from 'components/button/types';
import Link from 'next/link';
import Image from 'next/image';
import Button from 'components/button';

import classes from 'styles/features/EntryOptions.module.scss';

const {
	wrapper,
	login,
	register,
	download,
	imageWrapper,
	source,
	buttonWrapper,
	buttonContent,
	space_8,
	space_16
} = classes;
const sourceButton: TAppendClass = {
	appendWrapper: buttonWrapper,
	appendContent: buttonContent
}

function EntryOptions() {
	function _renderDownloadOptions() {
		return (
			<div>
				<div className={ download }>
					<div className={ imageWrapper }>
						<Image
							src="/images/download.svg"
							layout="fill"
							alt="Uber Eats 優食"
						/>
					</div>
					<div className={ space_16 } />
					<p>App 為您帶來更多美食佳餚。</p>
				</div>
				<div className={ source }>
					<Link
						href="https://apps.apple.com/us/app/uber-eats-food-delivery/id1058959277"	
					>
						<a>
							<Button
								appendClass={ sourceButton }
								icon={
									<Image
										src="/images/ios.svg"
										width="16"
										height="16"
										alt="iPhone"
									/>
								}
								text="iPhone"
							/>
						</a>
					</Link>
					<div className={ space_8 } />
					<Link
						href="https://play.google.com/store/apps/details?id=com.ubercab.eats"
					>
						<a>
							<Button
								appendClass={ sourceButton }
								icon={
									<Image
										src="/images/android.svg"
										width="16"
										height="16"
										alt="Android"
									/>
								}
								text="Android"
							/>
						</a>
					</Link>
				</div>
			</div>
		)
	}

	return (
		<div
			className={ wrapper }
			onClick={event => event.stopPropagation()}
		>
			<div>
				<Link href="#">
					<a className={ login }>登入</a>
				</Link>
				<div className={ register }>
					<li>建立企業帳戶</li>
					<li>新增您的餐廳</li>
					<li>註冊成為外送夥伴</li>
				</div>
			</div>
			{ _renderDownloadOptions() }
		</div>
	)
}

export default EntryOptions;
