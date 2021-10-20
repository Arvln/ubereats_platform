import Image from 'next/image';

function Header() {
	return (
		<header>
			<Image src="/images/menu.svg" width={20} height={20} />
			<Image src="/images/logo.svg" width={146} height={24} />
			<Image src="/images/location.svg" width={16} height={24} />
			<Image src="/images/search.svg" width={24} height={24} />
			<Image src="/images/cart.svg" width={16} height={16} />
			header
		</header>
	)
}

export default Header;
