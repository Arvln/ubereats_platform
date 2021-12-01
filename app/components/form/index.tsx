import { Prop } from './types';
import { TAppendClass } from 'components/button/types';
import { Button } from 'components';
import Image from 'next/image';

import classes from 'styles/components/Form.module.scss';

const {
	wrapper,
	content,
	height_80,
	buttonWrapper,
	test
} = classes;
const button: TAppendClass = {
	appendWrapper: buttonWrapper,
	appendContent: ''
};

function Form({ data }: Prop) {
	return (
		<div className={wrapper}>
			<div className={height_80} />
			<div className={content}>
				<Button
					appendClass={button}
					icon={
						<Image
							src="/images/close.svg"
							width="24"
							height="24"
							alt="Close"
						/>
					}
				/>
				{data}
			</div>
			<div className={height_80} />
		</div>
	);
};

export default Form;
