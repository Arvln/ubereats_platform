import { render, screen } from '@testing-library/react';
import '@testing-library/jest-dom';
import { Arrow } from "components";

jest.mock('next/image', () => ({
  __esModule: true,
  default: ({ src, alt }: { src: string; alt: string }) => (
    <img src={src} alt={alt} />
  ),
}));

describe('Test Arrow Component', () => {
  test('Should render correctly', () => {
    render(<Arrow appendWrapper="test-class" />);

    const wrapperDiv = screen.getByTestId('arrow-wrapper');
    expect(wrapperDiv).toBeInTheDocument();
  });

  test('Should render Button component inside Arrow', () => {
    render(<Arrow appendWrapper="test-class" />);

    const buttonElement = screen.getByTestId('button-wrapper');
    expect(buttonElement).toBeInTheDocument();
  });

  test('Should combine the appendWrapper class correctly', () => {
    render(<Arrow appendWrapper="extra-class" />);

    const wrapperDiv = screen.getByTestId('button-wrapper');
    expect(wrapperDiv).toHaveClass('extra-class');
  });

  test('Should render Image with correct src and alt attributes', () => {
    render(<Arrow appendWrapper="test-class" />);

    const imageElement = screen.getByRole('img', { name: /arrow/i });
    expect(imageElement).toHaveAttribute('src', '/images/arrow.svg');
    expect(imageElement).toHaveAttribute('alt', 'Arrow');
  });
});
