import Image from 'next/image';
import Link from 'next/link';

import {
	wrapper,
	moreOptionsWrapper,
	brand,
	logoWrapper,
	download,
	moreOptions,
	selectLanguage,
	about,
	socialMedia,
	policy,
	statement,
	space_8,
	space_16,
	space_24,
	space_40
} from 'styles/features/Footer.module.scss';

function Footer() {
	return (
		<footer className={ wrapper }>
			<div className={ moreOptionsWrapper }>
				<div className={ brand }>
					<div className={ logoWrapper }>
						<Image
							src="/images/footer_logo.svg"
							width={146}
							height={24}
							alt="Logo"
						/>
					</div>
					<div className={ download }>
						<Image
							src="/images/app_store.svg"
							width={135}
							height={40}
							alt="App Store"
						/>
						<div className={ space_16 } />
						<Image
							src="/images/google_play.png"
							width={135}
							height={40}
							alt="Google Play"
						/>
					</div>
				</div>
				<div className={moreOptions}>
					<ul>
						<li>
							<Link href="https://help.uber.com/ubereats">取得協助</Link>
						</li>
						<li>
							<Link href="https://www.ubereats.com/restaurant">新增您的餐廳</Link>
						</li>
						<li>
							<Link href="https://www.uber.com/drive/delivery">註冊成為合作外送夥伴</Link>
						</li>
						<li>
							<Link href="https://www.uber.com/business/eats">建立企業帳戶</Link>
						</li>
						<li>
							<Link href="#">首份訂單可享折扣優惠</Link>
						</li>
					</ul>
				</div>
				<div className={moreOptions}>
					<ul>
						<li>
							<Link href="https://www.ubereats.com/tw/near-me">我附近的美食外送</Link>
						</li>
						<li>
							<Link href="https://www.ubereats.com/tw/location">檢視所有城市</Link>
						</li>
						<li>
							<Link href="https://www.ubereats.com/tw/location#all-countries">查看所有國家/地區</Link>
						</li>
						<li>
							<Link href="https://www.uber.com/blog/eat">閱讀我們的部落格</Link>
						</li>
						<li>
							<Link href="https://about.ubereats.com">關於 Uber Eats</Link>
						</li>
						<li>
							<Link
								href="#"
							>
								<a className={ selectLanguage }>
									<Image
										src="/images/chinese.svg"
										width={16}
										height={15}
										alt="Chinese"
									/>
									<div className={ space_8 } />
									<span>中文</span>
								</a>
							</Link>
						</li>
					</ul>
				</div>
			</div>
			<hr />
			<div className={ about }>
				<div className={socialMedia}>
					<Link
						href="https://www.facebook.com/ubereats"
					>
						<a>
							<Image
								src="/images/facebook.svg"
								width={16}
								height={16}
								alt="Facebook"
							/>
						</a>
					</Link>
					<div className={ space_24 } />
					<Link
						href="https://www.twitter.com/ubereats"
					>
						<a>
							<Image
								src="/images/twitter.svg"
								width={16}
								height={16}
								alt="Twitter"
							/>
						</a>
					</Link>
					<div className={ space_24 } />
					<Link
						href="https://www.instagram.com/ubereats"
					>
						<a>
							<Image
								src="/images/instagram.svg"
								width={16}
								height={16}
								alt="Instagram"
							/>
						</a>
					</Link>
				</div>
				<div className={ policy }>
					<Link href="https://www.uber.com/legal/privacy/users">隱私政策</Link>
					<div className={ space_40 } />
					<Link href="https://www.uber.com/terms">條款</Link>
					<div className={ space_40 } />
					<Link href="https://help.uber.com/ubereats/article/uber-eats-pricing?nodeId=2adbed88-9822-4690-9529-3061c4821755">價格</Link>
					<div className={ space_40 } />
					<Link href="https://privacy.uber.com/privacy/california">請勿銷售我的資訊 (加州)</Link>
				</div>
			</div>
			<div className={ statement }>
				<div>
					本網站受到 reCAPTCHA 和 Google <Link href="https://policies.google.com/privacy">隱私政策</Link>的保護，且適用<Link href="https://policies.google.com/terms">服務條款</Link>。
				</div>
				<div className={space_40} />
				<div>© 2021 Uber Technologies Inc.</div>
			</div>
		</footer>
	)
}

export default Footer;
