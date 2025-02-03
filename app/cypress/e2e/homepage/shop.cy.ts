/// <reference types="cypress" />

describe('Shop ui test', () => {
  it('Should place an order correctly', () => {
    cy.visit('/')
    cy.contains('九湯屋日本拉麵').click()
    cy.get('li[data-testid^="good-detail-"]').first().click()

    cy.get('div[data-testid="order-amount"]').should('have.text', '1')
    cy.get('img[alt="Increment"]').click()
    cy.get('div[data-testid="order-amount"]').should('have.text', '2')
    cy.get('img[alt="Decrement"]').click()
    cy.get('div[data-testid="order-amount"]').should('have.text', '1')

    cy.get('button[data-testid="add-to-cart"]').click()
    cy.get('img[alt="Close"]').click()
  })
})
