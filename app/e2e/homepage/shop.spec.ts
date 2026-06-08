import { test, expect } from '@playwright/test';

test.describe('Shop ui test', () => {
  test('Should place an order correctly', async ({ page }) => {
    await page.goto('/');
    await page.getByText('九湯屋日本拉麵').first().click();
    await page.locator('li[data-testid^="good-detail-"]').first().click();

    const orderAmount = page.locator('div[data-testid="order-amount"]');
    await expect(orderAmount).toHaveText('1');
    await page.locator('img[alt="Increment"]').click();
    await expect(orderAmount).toHaveText('2');
    await page.locator('img[alt="Decrement"]').click();
    await expect(orderAmount).toHaveText('1');

    await page.locator('button[data-testid="add-to-cart"]').click();
    await page.locator('img[alt="Close"]').click();
  });
});
