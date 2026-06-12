import express from "express";
import { graphqlHTTP } from "express-graphql";
import { schema } from "./schema";
import { query } from "./db/query";

const app = express();
const SERVER_PORT = process.env.SERVER_PORT;

app.use(
  "/",
  graphqlHTTP({
    schema,
    graphiql: true,
  }),
);

app.get("/health/db", async (_, res) => {
  try {
    await query("SELECT 1");
    res.status(200).json({ status: "ok", message: "connected" });
  } catch (error) {
    res.status(500).json({ status: "error", message: "disconnected" });
  }
});

app.listen(SERVER_PORT, () => {
  console.log(`server running on port ${SERVER_PORT}`);
});
