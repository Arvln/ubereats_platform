import { Prop } from './types';

import classes from 'styles/features/store/Sidebar.module.scss';

const {
	wrapper,
	buttonWrapper,
	buttonContent,
	borderBottom
} = classes;

function Sidebar({ data, position }: Prop) {
	function _renderLabel() {
		const wrapper = buttonWrapper;

		return (
			data.map(({ label }, index) => {
				const button =
					index === position ? `${buttonContent} ${borderBottom}` : buttonContent;

				return (
					<li
						className={wrapper}
						key={label}
					>
						<button className={button}>
							<div>{label}</div>
						</button>
					</li>
				)
			})
		);
	};

	return (
		<div>
			<nav className={wrapper}>
				{_renderLabel()}
			</nav>
		</div>
	);
};

export default Sidebar;
