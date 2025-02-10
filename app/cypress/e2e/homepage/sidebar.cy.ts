/// <reference types="cypress" />

describe('sidebar ui test', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it('Should go back to home page by clicking logo image', () => {
    const baseUrl = Cypress.config().baseUrl as string
    cy.get('img[alt="Logo"]').each(logo => {
      cy.wrap(logo).click()
      cy.location('pathname', { timeout: 10000 }).should('eq', '/')
    })
  })

  it('Should render search bar can type in', () => {
    cy.get('input[placeholder="美食、生鮮雜貨、飲料等"]')
      .type('burger')
      .should('have.value', 'burger')
  })

  it('Should render classification options', () => {
    cy.get('input[type="radio"][name="RECOMMEND"]').should('be.checked')
    cy.get('input[type="radio"][name="POPULAR"]').should('exist')
    cy.get('input[type="radio"][name="SCORE"]').should('exist')
    cy.get('input[type="radio"][name="DELIVERY_TIME"]')
      .should('exist')
      .click()
      .should('be.checked')
  })

  it('Should render price range options', () => {
    cy.contains('$').should('exist')
    cy.contains('$$').should('exist')
    cy.contains('$$$').should('exist')
    cy.contains('$$$$').should('exist')
  })

  it('Should render dilivery cost options', () => {
    cy.contains('最低').should('exist')
    cy.contains('低').should('exist')
    cy.contains('中等').should('exist')
    cy.contains('較高').should('exist')
  })

  it('Should render dietary restriction options', () => {
    cy.contains('蔬食料理').should('exist')
    cy.contains('純素食料理').should('exist')
    cy.contains('無麩質料理').should('exist')
    cy.contains('過敏者可食用').should('exist')
  })
})
