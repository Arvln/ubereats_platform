import type { Config } from 'jest';

const config: Config = {
  rootDir: './',
  preset: 'ts-jest',
  testEnvironment: 'jsdom',
  transform: {
    '^.+\\.scss$': 'jest-transform-stub',
  },
  moduleNameMapper: {
    '^components/(.*)$': '<rootDir>/components/$1',
    '^features/(.*)$': '<rootDir>/features/$1',
    '^pages/(.*)$': '<rootDir>/pages/$1',
    '^graphql/(.*)$': '<rootDir>/graphql/$1',
    '^styles/(.*)$': '<rootDir>/styles/$1',
    '^themes/(.*)$': '<rootDir>/themes/$1',
    '^utils/(.*)$': '<rootDir>/utils/$1',
    '^types/(.*)$': '<rootDir>/types/$1',
    '^enums/(.*)$': '<rootDir>/enums/$1',
  },
};

export default config;
