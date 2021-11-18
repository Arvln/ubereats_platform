import express from 'express';
import { graphqlHTTP } from 'express-graphql';
import { schema } from './schema';

const app = express();
const SERVER_PORT = process.env.SERVER_PORT;

app.use('/', graphqlHTTP({
	schema,
	graphiql: true,
}));

app.listen(SERVER_PORT, () => {
	console.log(`server running on port ${SERVER_PORT}`);
});
