import { useCallback, useState } from 'react';
import Image from 'next/image';
import Button from 'components/button';
import { TAppendClass } from 'components/button/types';

import {
	wrapper,
	deliveryOptions,
	deliveryOption,
	deliveryButtonWrapper,
	deliveryButtonContent,
	deliveryButtonSelected,
	locationChoosingWrapper,
	locationButtonWrapper,
	locationButtonContent,
	searchbarWrapper,
	searchbar,
	searchbarShadow,
	cartWrapper,
	cartButtonWrapper,
	cartButtonContent,
	loginWrapper,
	loginButtonWrapper,
	loginButtonContent,
	space_16,
	space_24,
	space_32,
	space_40,
	space_64,
} from 'styles/features/Header.module.scss';

const unSelectedButton: TAppendClass = {
	appendWrapper: deliveryButtonWrapper,
	appendContent: deliveryButtonContent
}

const selectedButton: TAppendClass = {
	...unSelectedButton,
	appendWrapper: `${deliveryButtonWrapper} ${deliveryButtonSelected}`
}

const locationButton: TAppendClass = {
	appendWrapper: locationButtonWrapper,
	appendContent: locationButtonContent
}

const cartButton: TAppendClass = {
	appendWrapper: cartButtonWrapper,
	appendContent: cartButtonContent
}

const loginButton: TAppendClass = {
	appendWrapper: loginButtonWrapper,
	appendContent: loginButtonContent
}

function Header() {
	const [isDeliveried, setIsDeliveried] = useState<boolean>(true);
	const deliveryButtonClass = isDeliveried ? selectedButton : unSelectedButton;
	const takeOutButtonClass = isDeliveried ? unSelectedButton : selectedButton;

	const _handleElementFocus = () => {
		const searchBarInput = document.getElementsByClassName(searchbarWrapper)[0];
		searchBarInput.classList.add(searchbarShadow);
	}

	const _handleElementBlur = () => {
		const searchBarInput = document.getElementsByClassName(searchbarWrapper)[0];
		searchBarInput.classList.remove(searchbarShadow);
	}

	return (
		<header className={ wrapper }>
			<Image
				src="/images/dropdown.svg"
				width={20}
				height={20}
				alt="dropdown"
			/>
			<div className={ space_32 } />
			<Image
				src="/images/logo.svg"
				width={146}
				height={24}
				alt="logo"
			/>
			<div className={ space_40 } />
			<div className={ deliveryOptions }>
				<div
					className={ deliveryOption }
					onClick={() => setIsDeliveried(!isDeliveried)}
				>
					<Button
						appendClass={ deliveryButtonClass }
						text='外送'
					/>
				</div>
				<div
					className={ deliveryOption }
					onClick={() => setIsDeliveried(!isDeliveried)}
				>
					<Button
						appendClass={ takeOutButtonClass }
						text='外帶'
					/>
				</div>
			</div>
			<div className={ space_16 } />
			<div className={ locationChoosingWrapper }>
				<Button
					appendClass={ locationButton }
					icon={
						<Image
							src="/images/location.svg"
							width={16}
							height={24}
							alt="location"
						/>
					}
					text={'ABCD . A Better Coffee & Doughnut  •  立刻'}
				/>
			</div>
			<div className={ space_64 } />
			<div className={ searchbarWrapper }>
				<label htmlFor="search-input">想吃點什麼</label>
				<div className={ searchbar }>
					<Image
						src="/images/search.svg"
						width={24}
						height={24}
						alt="search"
					/>
					<div className={ space_16 } />
					<input
						type="text"
						placeholder="想吃點什麼?"
						onFocus={() => _handleElementFocus()}
						onBlur={() => _handleElementBlur()}
					/>
				</div>
			</div>
			<div className={ space_24 } />
			<div className={ cartWrapper }>
				<Button
					appendClass={ cartButton }
					icon={
						<Image
							src="/images/cart.svg"
							width={16}
							height={16}
							alt="cart" />
					}
					text="購物車 • 0"
				/>
			</div>
			<div className={space_24} />
			<div className={ loginWrapper }>
				<Button
					appendClass={ loginButton }
					text="登入"
				/>
			</div>
		</header>
	)
}

export default Header;
