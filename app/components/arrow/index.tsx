import { Prop } from './types';
import { TAppendClass } from 'components/button/types';
import Image from 'next/image';
import { Button } from 'components';

import classes from 'styles/components/Arrow.module.scss';

const {
	wrapper,
	buttonWrapper
} = classes;

function Arrow({ appendWrapper }: Prop) {
	const button: TAppendClass = {
		appendWrapper: `${appendWrapper ?? ''} ${buttonWrapper}`,
		appendContent: ''
	};

	return (
		<div className={wrapper} data-testid="arrow-wrapper">
			<Button
				appendClass={button}
				icon={
					<Image
						src="/images/arrow.svg"
						width={16}
						height={16}
						alt="Arrow"
					/>
				}
			/>
		</div>
	);
};

export default Arrow;
