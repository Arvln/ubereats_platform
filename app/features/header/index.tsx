import Image from 'next/image';
import Button from 'components/button';

function Header() {
	return (
		<header>
			<div className="dropdown-wrapper">
				<Image src="/images/menu.svg" width={20} height={20} />
			</div>
			<div className="logo-wrapper">
				<Image src="/images/logo.svg" width={146} height={24} />
			</div>
			<div className="delivery-options-button-wrapper">
				<Button
					text='外送'
				/>
				<Button
					text='外帶'
				/>
			</div>
			<div className="location-choosing-button-wrapper">
				<Button
					icon={<Image src="/images/location.svg" width={16} height={24} />}
					text={'ABCD . A Better Coffee & Doughnut'}
				/>
			</div>
			<div className="searchbar-wrapper">
				<label htmlFor="search-input">想吃點什麼</label>
				<Image src="/images/search.svg" width={24} height={24} />
				<input type="text" placeholder="想吃點什麼?" />
			</div>
			<div className="cart-wrapper">
				<Button
					icon={<Image src="/images/cart.svg" width={16} height={16} />}
					text="購物車 • 0"
				/>
			</div>
			<div className="login-">
				<Button
					text="登入"
				/>
			</div>
		</header>
	)
}

export default Header;
