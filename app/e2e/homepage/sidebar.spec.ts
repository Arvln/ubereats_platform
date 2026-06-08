import { test, expect } from '@playwright/test';

test.describe('sidebar ui test', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
  });

  test('Should go back to home page by clicking logo image', async ({ page }) => {
    const logos = page.locator('img[alt="Logo"]');
    const count = await logos.count();
    for (let i = 0; i < count; i++) {
      await logos.nth(i).click();
      await expect(page).toHaveURL('/');
    }
  });

  test('Should render search bar can type in', async ({ page }) => {
    const search = page.locator('input[placeholder="美食、生鮮雜貨、飲料等"]');
    await search.fill('burger');
    await expect(search).toHaveValue('burger');
  });

  test('Should render classification options', async ({ page }) => {
    await expect(page.locator('input[type="radio"][name="RECOMMEND"]')).toBeChecked();
    await expect(page.locator('input[type="radio"][name="POPULAR"]')).toBeAttached();
    await expect(page.locator('input[type="radio"][name="SCORE"]')).toBeAttached();

    const deliveryTime = page.locator('input[type="radio"][name="DELIVERY_TIME"]');
    await expect(deliveryTime).toBeAttached();
    await deliveryTime.check();
    await expect(deliveryTime).toBeChecked();
  });

  test('Should render price range options', async ({ page }) => {
    await expect(page.getByText('$', { exact: true }).first()).toBeVisible();
    await expect(page.getByText('$$', { exact: true }).first()).toBeVisible();
    await expect(page.getByText('$$$', { exact: true }).first()).toBeVisible();
    await expect(page.getByText('$$$$', { exact: true }).first()).toBeVisible();
  });

  test('Should render dilivery cost options', async ({ page }) => {
    await expect(page.getByText('最低').first()).toBeVisible();
    await expect(page.getByText('低', { exact: true }).first()).toBeVisible();
    await expect(page.getByText('中等').first()).toBeVisible();
    await expect(page.getByText('較高').first()).toBeVisible();
  });

  test('Should render dietary restriction options', async ({ page }) => {
    await expect(page.getByText('蔬食料理').first()).toBeVisible();
    await expect(page.getByText('純素食料理').first()).toBeVisible();
    await expect(page.getByText('無麩質料理').first()).toBeVisible();
    await expect(page.getByText('過敏者可食用').first()).toBeVisible();
  });
});
