import { render, screen } from "@testing-library/react";
import '@testing-library/jest-dom'
import Button from ".";

const mockProps = {
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

    const wrapper = screen.getByTestId("wrapper");
    const content = screen.getByTestId("content");

    expect(wrapper).toBeInTheDocument();
    expect(content).toBeInTheDocument();

    expect(content.textContent).toBe(mockProps.text);
  });

  test("Should apply custom classes", () => {
    render(<Button {...mockProps} />);

    const wrapper = screen.getByTestId("wrapper");
    const content = screen.getByTestId("content");

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