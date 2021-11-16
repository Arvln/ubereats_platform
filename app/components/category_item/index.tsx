import { Prop } from './types';
import Link from 'next/link';

import classes from 'styles/components/CategoryItem.module.scss';

const { wrapper } = classes;

function CategoryItem({
	appendClass,
	pageUrl,
	icon,
	text
}: Prop) {
	const wrapperStyle = `${wrapper} ${appendClass}`

	return (
		<div className={ wrapperStyle }>
			<Link href={ pageUrl }>
				<a>
					{ icon }
					<span>{ text }</span>
				</a>
			</Link>
		</div>
	)
}

export default CategoryItem;
