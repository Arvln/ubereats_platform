import Image from 'next/image';

function Footer() {
	return (
		<footer>
			<Image src="/images/app_store.svg" width={135} height={40} />
			<Image src="/images/google_play.png" width={135} height={40} />
			<Image src="/images/chinese.svg" width={16} height={15} />
			<Image src="/images/facebook.svg" width={16} height={16} />
			<Image src="/images/twitter.svg" width={16} height={16} />
			<Image src="/images/instagram.svg" width={16} height={16} />
			footer
		</footer>
	)
}

export default Footer;
