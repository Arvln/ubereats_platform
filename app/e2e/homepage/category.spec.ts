import { test, expect } from '@playwright/test';

test.describe('category ui test', () => {
  test('Should redirect to correct page', async ({ page }) => {
    await page.goto('/zh-TW', { waitUntil: 'domcontentloaded' });

    const categoryLink = page
      .locator('div[data-testid="category-item-wrapper"]')
      .locator('a')
      .filter({ visible: true })
      .first();
    const categoryHref = await categoryLink.getAttribute('href');
    // A Next.js <Link> click can be a no-op until React finishes hydrating,
    // so retry the click until navigation to the category page actually happens.
    await expect(async () => {
      await categoryLink.click();
      await expect(page).toHaveURL(categoryHref!, { timeout: 3000 });
    }).toPass({ timeout: 30000 });

    await page.goto(categoryHref!, { waitUntil: 'domcontentloaded' });

    const shopLink = page
      .locator('li[data-testid^="shop-item-"]')
      .locator('a')
      .filter({ visible: true })
      .first();
    const shopHref = await shopLink.getAttribute('href');
    await expect(async () => {
      await shopLink.click();
      await expect(page).toHaveURL(shopHref!, { timeout: 3000 });
    }).toPass({ timeout: 30000 });
  });
});
