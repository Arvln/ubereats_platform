const express = require('express');

const app = express();

app.get('/', (req: any, res: any) => {
	console.log(req);
	res.send({ 'a': '1' });
})

app.listen(4000, () => {
  console.log('server running on port 4000');
})
