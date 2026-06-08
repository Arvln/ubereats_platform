import { test, expect } from '@playwright/test';

test.describe('category ui test', () => {
  test('Should redirect to correct page', async ({ page }) => {
    await page.goto('/');

    const categoryLink = page
      .locator('div[data-testid="category-item-wrapper"]')
      .locator('a')
      .first();
    const categoryHref = await categoryLink.getAttribute('href');
    await categoryLink.click();
    await expect(page).toHaveURL(categoryHref!);
    await page.goto(categoryHref!);

    const shopLink = page
      .locator('li[data-testid^="shop-item-"]')
      .locator('a')
      .first();
    const shopHref = await shopLink.getAttribute('href');
    await shopLink.click();
    await expect(page).toHaveURL(shopHref!);
  });
});
