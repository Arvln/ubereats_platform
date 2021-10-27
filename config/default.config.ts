import { config } from 'dotenv';
config();

const ENV = process.env;

export const productConfig = {
	db: {
		host: ENV.MYSQL_HOST,
		user: ENV.MYSQL_USER,
		password: ENV.MYSQL_PASSWORD,
		database: ENV.DATABASE_NAME
	}
}
