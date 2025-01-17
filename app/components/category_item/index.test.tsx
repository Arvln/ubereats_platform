import { render, screen } from '@testing-library/react';

import type { Prop } from './types';
import { CategoryItem }from 'components';

const mockProps: Prop = {
  appendClass: 'custom-class',
  pageUrl: '/test-url',
  icon: <svg data-testid="test-icon" />,
  text: 'Test Category',
};

describe('Test CategoryItem Component', () => {
  test('Should render with the correct text and icon', () => {
    render(<CategoryItem {...mockProps} />);

    const linkElement = screen.getByRole('link');
    expect(linkElement).toHaveAttribute('href', mockProps.pageUrl);

    const textElement = screen.getByTestId('category-item-content');
    expect(textElement).toHaveTextContent(mockProps.text);

    const iconElement = screen.getByTestId('test-icon');
    expect(iconElement).toBeInTheDocument();
  });

  test('Should apply custom class', () => {
    render(<CategoryItem {...mockProps} />);

    const wrapperElement = screen.getByTestId('category-item-wrapper');
    expect(wrapperElement).toHaveClass('custom-class');
  });
});
