# Handmade Ceramics Store — PRD

## Problem Statement

A handmade-ceramics business currently has no dedicated online storefront: it
cannot showcase its catalog, let customers assemble an order, or take secure
payment without falling back to manual, ad-hoc sales channels (e.g. social
media messages). This costs sales, makes inventory hard to track, and gives
customers no self-service way to browse, buy, or know the status of an order.

## Solution

A single-seller online store for handmade ceramics where shoppers browse a
product catalog, build a cart, and check out with card payment — as a guest or
signed in — while the store's admin manages the catalog, inventory, and order
fulfillment through the same system.

## Actors

- **Shopper**: browses the catalog, manages a cart, checks out (as a guest or
signed in), and can view their own order history and status when signed in.
- **Store Admin**: signs in to manage the product catalog and inventory, and
to view and update the fulfillment status of incoming orders.

## User Stories

1. As a Shopper, I want to browse the product catalog, so that I can discover handmade ceramics available for purchase.
2. As a Shopper, I want to view detailed information about a product (photos, description, price, availability), so that I can decide whether to buy it.
3. As a Shopper, I want to search or filter products by category, so that I can find items I'm interested in faster.
4. As a Shopper, I want to add products to a cart, so that I can collect items before checking out.
5. As a Shopper, I want to update quantities or remove items from my cart, so that I can adjust my order before paying.
6. As a Shopper, I want to check out as a guest without creating an account, so that I can complete a purchase quickly.
7. As a Shopper, I want to pay for my order with a card, so that I can complete my purchase securely.
8. As a Shopper, I want to receive an email confirmation after checkout, so that I have a record of my order.
9. As a Shopper, I want to sign in to an account, so that I can view my past orders.
10. As a Shopper, I want to view the status of my order (e.g. packed, shipped, delivered), so that I know when to expect it.
11. As a Store Admin, I want to sign in securely, so that only authorized staff can manage the store.
12. As a Store Admin, I want to create, edit, and remove products in the catalog, so that I can keep listings accurate and up to date.
13. As a Store Admin, I want to manage inventory levels for each product, so that shoppers can't order out-of-stock items.
14. As a Store Admin, I want to view incoming orders, so that I can fulfill them.
15. As a Store Admin, I want to update an order's fulfillment status, so that shoppers can track progress.

## Product Decisions

- This is a **single-seller store**: one business sells its own products; there
is no multi-vendor marketplace or seller onboarding.
- **Guest checkout is allowed.** Shoppers can complete a purchase without an
account; signing in (via Thunder SSO, the organization's standard for every
web app) is optional and used to view order history and status.
- The **Store Admin must sign in** (via Thunder SSO) to manage the catalog,
inventory, and orders.
- **Payments** are captured via a third-party card payment provider (e.g.
Stripe); the concrete provider is bound at design time.
- **Notifications** are limited to a single transactional **email order
confirmation** sent after checkout; no shipping/status-update emails in
Phase 1.
- The **Admin tracks order fulfillment status** (e.g. packed, shipped,
delivered), and shoppers can see that status for their own orders.

## Phasing

- **Phase 1 — Launch the single-seller ceramics storefront**: deliver the full
shopper journey (browse, cart, guest or signed-in checkout, card payment,
email confirmation, order status) and the full admin journey (catalog,
inventory, order fulfillment management). Stories: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15.

## Out of Scope

- Multi-vendor marketplace features (multiple sellers, seller onboarding, payout splitting).
- Product reviews, ratings, or Q&amp;A.
- Wishlists or saved-for-later lists.
- Shipping- and status-update emails/SMS beyond the initial order confirmation.
- Discount codes, promotions, and gift cards.
- Multi-currency pricing.
- Returns, refunds, and exchange workflows.

## Open Questions

1. How should shipping cost and tax be calculated at checkout (flat rate, carrier-calculated, tax-by-region, etc.)? — deferred, does not block design; can default to a simple flat-rate model at design time.

## Further Notes

None.