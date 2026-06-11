import { test, expect } from '@playwright/test';

test.describe('Shop ui test', () => {
  test('Should place an order correctly', async ({ page }) => {
    await page.goto('/zh-TW', { waitUntil: 'domcontentloaded' });

    // A Next.js <Link> click can be a no-op until React finishes hydrating,
    // so retry the click until the store page navigation actually happens.
    await expect(async () => {
      await page.getByText('九湯屋日本拉麵').filter({ visible: true }).first().click();
      await expect(page).toHaveURL(/\/store\//, { timeout: 3000 });
    }).toPass({ timeout: 30000 });

    // Some menu items (e.g. "買1送1" free gifts) have no price and open no order
    // form on click, so click visible items until the order form actually opens.
    const goods = page.locator('li[data-testid^="good-detail-"]').filter({ visible: true });
    const orderAmount = page.locator('div[data-testid="order-amount"]');
    await goods.first().waitFor({ state: 'visible' });
    const goodsCount = await goods.count();
    for (let i = 0; i < goodsCount; i++) {
      await goods.nth(i).click();
      try {
        await orderAmount.waitFor({ state: 'visible', timeout: 2000 });
        break;
      } catch {
        // not an orderable item; try the next one
      }
    }

    await expect(orderAmount).toHaveText('1');
    await page.locator('img[alt="Increment"]').click();
    await expect(orderAmount).toHaveText('2');
    await page.locator('img[alt="Decrement"]').click();
    await expect(orderAmount).toHaveText('1');

    await page.locator('button[data-testid="add-to-cart"]').click();
    await page.locator('img[alt="Close"]').click();
  });
});
