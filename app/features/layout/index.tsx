import { Prop, THandleForm } from './types';
import { createContext, useState } from 'react';
import Head from 'next/head';
import { Form } from 'components';
import Popups from 'features/popups';
import EntryOptions from 'features/entry_options';
import Header from 'features/header';
import Footer from 'features/footer';

import classes from 'styles/features/Layout.module.scss';

const {
	hideContent,
	showContent,
	showForm,
	hideForm
} = classes;
let handleForm: THandleForm = () => {};

function Layout({ children }: Prop) {
	const [isShowEntryOptions, setIsShowEntryOptions] = useState<boolean>(false);
	const [isShowForm, setIsShowFrom] = useState<boolean>(false);
	const [form, setForm] = useState<JSX.Element>(<></>);

	function _handleBodyStyle(isShow: boolean) {
		const body = document.body.classList;
		const newContent: string = isShow ? showContent : hideContent;
		const oldContent: string = isShow ? hideContent : showContent;

		body.add(newContent);
		body.remove(oldContent);
	};

	function _handleEntryOptions() {
		_handleBodyStyle(isShowEntryOptions);
		setIsShowEntryOptions(!isShowEntryOptions);
	};

	handleForm = form => {
		_handleBodyStyle(isShowForm);
		setIsShowFrom(!isShowForm);
		form && setForm(form);
	};

	function _renderEntryOptionsWithMask() {
		return (
			<Popups
				isShow={isShowEntryOptions}
				hide={_handleEntryOptions}
			>
				<EntryOptions />
			</Popups>
		);
	};

	function _renderFormWithMask() {
		const wrapper: string = isShowForm ? showForm : hideForm;

		return (
			<div className={wrapper}>
				<Popups
					isShow={isShowForm}
					hide={handleForm}
				>
					<Form data={form} />
				</Popups>
			</div>
		);
	};

	return (
		<FormContext.Provider value={handleForm}>
			<Head>
				<title>線上訂購餐點 | 美食外送 App | Uber Eats 優食</title>
				<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0" />
				<meta name="description" content="Uber Eats 優食專業品質外送網站，餓了訂外送就上Uber Eats 優食。Uber Eats 優食覆蓋全國各城市優質外送商家、速食和特色美食，擁有優秀的外送訂餐平台和外送送餐團隊，提供24小時叫外送、外送網站訂餐服務。" />
				<meta name="keywords" content="外送,Uber Eats,外送網站,外送訂餐平台,優食,Uber Eats 優食" />
				<link rel="shortcut icon" type="image/x-icon" href="/images/favicon.ico" />
				<link rel="icon" type="image/x-icon" href="/images/favicon.ico" />
			</Head>
			{_renderEntryOptionsWithMask()}
			<Header
				showEntryOptions={_handleEntryOptions}
				showDeliveryDetails={handleForm}
			/>
				{children}
			<Footer />
			{_renderFormWithMask()}
		</FormContext.Provider>
	);
};

export const FormContext = createContext(handleForm);

export default Layout;
