import { Prop } from './types';
import { useState } from 'react';
import Head from 'next/head';
import EntryOptions from 'features/entry_options';
import Header from 'features/header';
import Footer from 'features/footer';

import {
	wrapper,
	showMask,
	hideMask,
	showMaskContent,
	hideMaskContent,
	hideContent,
	showContent
} from 'styles/features/Layout.module.scss';

function Layout({ children }: Prop) {
	const [isEliminateMask, setIsEliminateMask] = useState<boolean>(true);
	const maskWrapper = isEliminateMask ? hideMask : showMask;
	const maskContent = isEliminateMask ? hideMaskContent : showMaskContent;

	function _handleMask() {
		console.log(isEliminateMask);
		
		const body = document.body.classList;
		const newContent: string = isEliminateMask ? hideContent : showContent;
		const oldContent: string = isEliminateMask ? showContent : hideContent;

		setIsEliminateMask(!isEliminateMask);
		body.add(newContent);
		body.remove(oldContent);
	}

	return (
		<>
			<Head>
				<title>線上訂購餐點 | 美食外送 App | Uber Eats 優食</title>
				<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0" />
				<meta name="description" content="Uber Eats 優食專業品質外送網站，餓了訂外送就上Uber Eats 優食。Uber Eats 優食覆蓋全國各城市優質外送商家、速食和特色美食，擁有優秀的外送訂餐平台和外送送餐團隊，提供24小時叫外送、外送網站訂餐服務。" />
				<meta name="keywords" content="外送,Uber Eats,外送網站,外送訂餐平台,優食,Uber Eats 優食"/>
				<link rel="shortcut icon" type="image/x-icon" href="/images/favicon.ico" />
				<link rel="icon" type="image/x-icon" href="/images/favicon.ico" />
			</Head>
			<div
				className={ wrapper }
				onClick={() => _handleMask()}
			>
				<div className={ maskWrapper }>
					<div className={ maskContent }>
						<EntryOptions />
					</div>
				</div>
			</div>
			<Header handleSideBar={_handleMask} />
				{ children }
			<Footer />
		</>
	)
}

export default Layout;
