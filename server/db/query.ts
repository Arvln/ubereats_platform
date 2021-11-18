import mysql from 'mysql2/promise';
import { productConfig } from '../config/default.config';
const {
	db: dbConfig
} = productConfig;
const pool = mysql.createPool(dbConfig);

export async function query(sql: string, params?: unknown[]): Promise<unknown> {
	const [result,] = await pool.query(sql, params);

	return result;
}
