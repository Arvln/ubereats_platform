/// <reference types="cypress" />

describe('category ui test', () => {
  it('Should redirect to correct page', () => {
    cy.visit('/')

    cy.get('div[data-testid="category-item-wrapper"]')
      .find('a').first().then(link => {
        const href = link.attr('href')

        cy.wrap(link).click()
        cy.location('pathname', { timeout: 10000 }).should('eq', href)
        cy.visit(`${Cypress.config().baseUrl}${href}`)
      })

    cy.get('li[data-testid^="shop-item-"]')
      .find('a').first().then(link => {
        const href = link.attr('href')

        cy.wrap(link).click()
        cy.location('pathname', { timeout: 10000 }).should('eq', href)
      })
  })
})
