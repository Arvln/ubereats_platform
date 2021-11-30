import { Dispatch, SetStateAction } from "react";
import { TGoodChannel } from "types/pages/store";

export type Prop = {
	data: TGoodChannel[];
	position: number;
	setPosition: Dispatch<SetStateAction<number>>;
};
