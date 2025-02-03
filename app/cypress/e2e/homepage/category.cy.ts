/// <reference types="cypress" />

describe('category ui test', () => {
  it('Should redirect to correct page', () => {
    cy.visit('/')

    const baseUrl = Cypress.config().baseUrl as string
    cy.get('div[data-testid="category-item-wrapper"]')
      .find('a').first().then(link => {
        
        const href = link.attr('href')

        cy.wrap(link).click()
        cy.url().should('eq', `${baseUrl}${href}`)
        cy.visit(`${baseUrl}${href}`)
      })

    cy.get('li[data-testid^="shop-item-"]')
      .find('a').first().then(link => {
        const href = link.attr('href')

        cy.wrap(link).click()
        cy.url().should('eq', `${baseUrl}${href}`)
      })
  })
})
