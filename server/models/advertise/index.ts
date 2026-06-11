import { TAdvertise } from "types/pages/marketing/advertise";
import { query } from "../../db/query";

export async function getData(uuid: string) {
  const advertise = (await query(
    `
			SELECT
				content
			FROM
				Table_Advertise
			WHERE
				uuid = UNHEX(?);
		`,
    [uuid.replace(/-/g, "")],
  )) as TAdvertise[];

  return advertise;
}
