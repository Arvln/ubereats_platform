import { render, screen, fireEvent } from '@testing-library/react';

import type { Prop } from './types';
import { Shop } from 'components';

jest.mock('next/image', () => ({
  __esModule: true,
  default: ({ src, alt, width, height, style, fill, ...props }: { src: string, alt: string, width?: number | string, height?: number | string, fill?: boolean, style?: React.CSSProperties }) => (
      <img
        src={src}
        alt={alt}
        width={width}
        height={height}
        style={style}
        {...props}
      />
    ),
}));

jest.mock('contexts', () => ({
  useLocale: jest.fn(() => ({ locale: 'zh-TW', changeLocale: jest.fn() })),
}));

const mockData: Prop['data'] = [
  {
    __typename: 'ChannelShop',
    name: 'Shop 1',
    deliveryCost: 100,
    shortestDeliveryTime: 30,
    score: 90,
    discountLabel: '10% off',
    imageSuffix: 'image1.jpg',
    uuid: '123',
  },
  {
    __typename: 'ChannelCategory',
    name: 'Shop 2',
    deliveryCost: 200,
    shortestDeliveryTime: 45,
    score: 80,
    discountLabel: '',
    imageSuffix: 'image2.jpg',
    uuid: '456',
  },
];

describe('Test Shop Component', () => {
  test('Should render shop items correctly', () => {
    render(<Shop data={mockData} size={8} imageHeight="200px" />);

    expect(screen.getByTestId('store-title-123')).toBeInTheDocument();
    expect(screen.getByTestId('store-title-456')).toBeInTheDocument();
  });

  test('Should render shop image correctly', () => {
    render(<Shop data={mockData} size={4} imageHeight="200px" />);

    const image1 = screen.getByTestId('image-wrapper-123').querySelector('img');
    expect(image1).toHaveAttribute('src', 'https://mockhost3/image1.jpg');

    const image2 = screen.getByTestId('image-wrapper-456').querySelector('img');
    expect(image2).toHaveAttribute('src', 'https://mockhost3/image2.jpg');
  });

  test('Should render score button with correct text', () => {
    render(<Shop data={mockData} size={4} imageHeight="200px" />);

    expect(screen.getByTestId('score-button-123')).toHaveTextContent('9.0');
  });

  test('Should display the discount message when available', () => {
    render(<Shop data={mockData} size={4} imageHeight="200px" />);

    expect(screen.getByTestId('discount-message-123')).toHaveTextContent('10% off');
  });

  test('Should not display discount message for shop without discount', () => {
    render(<Shop data={mockData} size={4} imageHeight="200px" />);

    const discountMessage = screen.queryByTestId('discount-text-456');
    expect(discountMessage).toHaveClass('hideEmpty');
  });

  test('Should handle favorite button click', () => {
    render(<Shop data={mockData} size={4} imageHeight="200px" />); 

    const favorButton = screen.getByTestId('favor-button-123');
    fireEvent.click(favorButton);
    expect(favorButton).toBeInTheDocument();
  });

  test('Should render correct detail content for pickup and delivery', () => {
    render(<Shop data={mockData} size={4} imageHeight="200px" />);

    expect(screen.getByTestId('cost-time-123')).toHaveTextContent('30–40分鐘');
    expect(screen.getByTestId('distance-123')).toHaveTextContent('0.1公里');
    expect(screen.getByTestId('cost-time-456')).toHaveTextContent('45–55分鐘');
  });

  test('Should render correct page size wrapper class', () => {
    render(<Shop data={mockData} size={4} imageHeight="200px" />);

    const shopItem = screen.getByTestId('shop-item-123');
    expect(shopItem).toHaveClass('wrapper shopWidth_4');
  });

  test('Should navigates to the store page when clicked correctly', () => {
    render(<Shop data={mockData} size={4} imageHeight="200px" />);

    const link = screen.getByTestId('store-title-123');
    expect(link.closest('a')).toHaveAttribute('href', '/zh-TW/store/Shop 1/123');
  });
});
