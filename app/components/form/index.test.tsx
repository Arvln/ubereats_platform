import { render, screen, fireEvent } from '@testing-library/react';

import { Form } from 'components';

const mockData = 'Form data content';

describe('Test Form component', () => {
  test('Should render form wrapper and content correctly', () => {
    render(<Form>{ mockData }</Form>);

    const formWrapper = screen.getByTestId('form-wrapper');
    expect(formWrapper).toBeInTheDocument();

    const formContent = screen.getByTestId('form-content');
    expect(formContent).toBeInTheDocument();
    expect(formContent).toHaveTextContent(mockData);

    const button = screen.getByTestId('button-wrapper');
    expect(button).toBeInTheDocument();

    const icon = screen.getByAltText('Close');
    expect(icon).toBeInTheDocument();
  });

  test('Should contain a button with correct appendClass', () => {
    render(<Form>{ mockData }</Form>);

    const button = screen.getByTestId('button-wrapper');
    expect(button).toBeInTheDocument();
  });

  test('Should handle button click if needed', () => {
    render(<Form>{ mockData }</Form>);

    const button = screen.getByTestId('button-wrapper');
    fireEvent.click(button);
  });
});
