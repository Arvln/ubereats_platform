export type TAppendClass = {
	appendWrapper: string,
	appendContent: string
}

export type Prop = {
	appendClass: TAppendClass;
	icon?: JSX.Element;
	text?: string;
}
