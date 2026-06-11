import { config } from "dotenv";
config();

const ENV = process.env;

export const productConfig = {
  db: {
    host: ENV.MYSQL_HOST,
    port: parseInt(ENV.MYSQL_PORT || "3306", 10),
    user: ENV.MYSQL_USER,
    password: ENV.MYSQL_PASSWORD,
    database: ENV.DATABASE_NAME,
    charset: "utf8mb4",
  },
};
