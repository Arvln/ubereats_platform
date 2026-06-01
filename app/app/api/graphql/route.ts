import { gqlServerClient } from 'api/graphql';
import { ClientError } from 'graphql-request';
import { NextRequest, NextResponse } from 'next/server';

type GraphqlRequestBody = {
  query: string;
  variables?: Record<string, unknown>;
};

export async function POST(request: NextRequest) {
  let body: GraphqlRequestBody;

  try {
    body = (await request.json()) as GraphqlRequestBody;
  } catch {
    return NextResponse.json(
      { errors: [{ message: 'Invalid JSON body' }] },
      { status: 400 },
    );
  }

  const { query, variables } = body;

  if (!query || typeof query !== 'string') {
    return NextResponse.json(
      { errors: [{ message: 'Missing query' }] },
      { status: 400 },
    );
  }

  try {
    const data = await gqlServerClient().request(query, variables);
    return NextResponse.json({ data });
  } catch (error) {
    if (error instanceof ClientError) {
      const status = error.response.status ?? 500;
      const errors = error.response.errors ?? [{ message: error.message }];
      return NextResponse.json({ errors }, { status });
    }

    const message =
      error instanceof Error ? error.message : 'GraphQL request failed';

    return NextResponse.json(
      { errors: [{ message }] },
      { status: 500 },
    );
  }
}
