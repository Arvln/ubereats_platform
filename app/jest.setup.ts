import '@testing-library/jest-dom';

process.env = {
  ...process.env,
  SHORTCUT_ICONS_SERVER_HOST: 'mockhost1',
  UTILS_ICONS_SERVER_HOST: 'mockhost2',
  STORE_IMAGE_SERVER_HOST: 'mockhost3'
}
