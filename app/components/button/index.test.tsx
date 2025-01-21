import { render, screen } from '@testing-library/react';

import type { Prop } from './types';
import { Button } from 'components';

const mockProps : Prop = {
  appendClass: {
    appendWrapper: "custom-wrapper",
    appendContent: "custom-content",
  },
  icon: <span data-testid="icon">icon</span>,
  text: "click",
};

describe("Test Button Component", () => {
  test("should render correctly", () => {
    render(<Button {...mockProps} />);

    const wrapper = screen.getByTestId("button-wrapper");
    const content = screen.getByTestId("button-content");

    expect(wrapper).toBeInTheDocument();
    expect(content).toBeInTheDocument();

    expect(content.textContent).toBe(mockProps.text);
  });

  test("Should apply custom classes", () => {
    render(<Button {...mockProps} />);

    const wrapper = screen.getByTestId("button-wrapper");
    const content = screen.getByTestId("button-content");

    expect(wrapper).toHaveClass("custom-wrapper");
    expect(content).toHaveClass("custom-content");
  });

  test("Should render icon", () => {
    render(<Button {...mockProps} />);

    const icon = screen.getByTestId("icon");
    expect(icon).toBeInTheDocument();
    expect(icon.textContent).toBe("icon");
  });
});
