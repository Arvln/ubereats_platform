import express from 'express';
import { graphqlHTTP } from 'express-graphql';
import cors from 'cors';
import { schema } from './schema';
import {
	HOME_URL,
} from './route';

const app = express();
const SERVER_PORT = process.env.SERVER_PORT;

app.use(cors());
app.use(HOME_URL, graphqlHTTP({
  schema,
  graphiql: true,
}));

app.listen(SERVER_PORT, () => {
  console.log(`server running on port ${SERVER_PORT}`);
})
