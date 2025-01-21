import { ReactNode } from 'react';
import Image from 'next/image';

import { TAppendClass } from 'components/button/types';
import { Button } from 'components';

import classes from 'styles/components/Form.module.scss';

const {
	wrapper,
	content,
	height_80,
	buttonWrapper
} = classes;
const button: TAppendClass = {
	appendWrapper: buttonWrapper,
	appendContent: ''
};

function Form({ children }: { children ?: ReactNode }) {
	return (
		<div className={wrapper} data-testid="form-wrapper">
			<div className={height_80} />
			<div className={content} data-testid="form-content">
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
				{children}
			</div>
			<div className={height_80} />
		</div>
	);
};

export default Form;
