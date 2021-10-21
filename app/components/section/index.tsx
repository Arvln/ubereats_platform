import { Prop } from './types';
import {
	defaultStyle,
	textWrapper
} from '@styles/components/section/Section.module.scss';

function Section({ appendClass, icon, text }: Prop) {
	const sectionClass = appendClass ? `${defaultStyle} ${appendClass}` : defaultStyle;

	return (
		<div className={ sectionClass }>
			{ icon }
			<div className={ textWrapper }>{ text }</div>
		</div>
	)
}

export default Section;
