import Head from 'next/head';
import Image from 'next/image';

import classes from 'styles/pages/Error.module.scss';

const {
	wrapper,
	content,
	imageWrapper,
	title
} = classes;

function Error() {
	return (
		<>
			<Head>
				<title>糟糕！發生錯誤 | Uber Eats 優食</title>
			</Head>
			<div className={wrapper}>
				<div className={content}>
					<div className={imageWrapper}>
						<Image
							src="/images/error.svg"
							width={226}
							height={160}
							alt="Error"
						/>
					</div>
					<div className={title}>糟糕！發生錯誤</div>
					<div>處理您的預約時發生錯誤。請稍後再試。</div>
				</div>
			</div>
		</>
	);
};

export default Error;
