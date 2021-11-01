import mysql from 'mysql2/promise';
import { productConfig } from '../../config/default.config';
const {
	db: dbConfig
} = productConfig;

export async function query(sql: string, params?: unknown[]) {
	const pool = await mysql.createPool(dbConfig);
	const [result,] = await pool.query(sql, params);

	return result;
}
