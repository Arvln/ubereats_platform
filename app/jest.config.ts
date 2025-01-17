import type { Config } from 'jest';
import { readFileSync } from 'fs';

const { compilerOptions } = JSON.parse(readFileSync('./tsconfig.json', 'utf8'));
const convertPathsToModuleNameMapper = (paths: typeof compilerOptions) => {
  const moduleNameMapper = {} as {
      [key: string]: string | string[];
  };
  const createRootPath = (basePath: string) => {
    if (basePath === 'styles') return `<rootDir>/${basePath}/globals.scss`;
    else if (basePath === 'utils') return `../<rootDir>/${basePath}/index.ts`;
    else return `<rootDir>/${basePath}/index.ts`;
  }
  const createPath = (basePath: string) => {
    if (basePath === 'utils') return `../<rootDir>/${basePath}/$1`;
    else return `<rootDir>/${basePath}/$1`;
  }

  Object.keys(paths).forEach((path) => {
    const basePath = path.replace('/*', '');

    moduleNameMapper[`^${basePath}/(.*)$`] = createRootPath(basePath);
    moduleNameMapper[`^${basePath}$`] = createPath(basePath);
  });

  return moduleNameMapper;
}

const config: Config = {
  rootDir: './',
  preset: 'ts-jest',
  testEnvironment: 'jsdom',
  transform: {
    '^.+\\.scss$': 'jest-transform-stub',
  },
  moduleNameMapper: convertPathsToModuleNameMapper(compilerOptions.paths)
};

export default config;
