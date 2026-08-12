# Handmade Ceramics Store — Design

## Overview

A single-seller online store for handmade ceramics. Shoppers browse a product
catalog, build a cart, and check out (as a guest or signed in) with a card
payment; the store admin manages the catalog, inventory, and order
fulfillment. The system is one React storefront/admin web application backed
by one Ballerina API service, with sign-in via Thunder, card capture via a
third-party payment provider, and order-confirmation email via a transactional
email provider.

## Context (C1)

```mermaid
graph TB
  shopper["Shopper"]
  admin["Store Admin"]

  subgraph system["Handmade Ceramics Store"]
    webapp["Ceramics Storefront (web-application)"]
    api["Ceramics API (service)"]
  end

  auth["Thunder Auth (identity server)"]
  payment["Payment Provider"]
  email["Email Provider"]

  shopper --> webapp
  admin --> webapp
  webapp --> api
  webapp --> auth
  api --> auth
  api --> payment
  api --> email
```

## Domain model (ER)

```mermaid
erDiagram
  CATEGORY {
    string id
    string name
  }
  PRODUCT {
    string id
    string name
    string description
    int priceCents
    string categoryId
    string imageUrl
    int stockQuantity
    boolean isActive
  }
  CUSTOMER {
    string id
    string email
    string name
  }
  CART {
    string id
    string customerId
    string status
  }
  CART_ITEM {
    string id
    string cartId
    string productId
    int quantity
  }
  ORDER {
    string id
    string customerId
    string email
    string status
    int totalCents
    string createdAt
  }
  ORDER_ITEM {
    string id
    string orderId
    string productId
    int quantity
    int unitPriceCents
  }
  PAYMENT {
    string id
    string orderId
    string provider
    string status
    int amountCents
  }

  CATEGORY ||--o{ PRODUCT : "groups"
  CART ||--o{ CART_ITEM : "contains"
  PRODUCT ||--o{ CART_ITEM : "referenced by"
  CUSTOMER ||--o{ CART : "owns (optional, guest carts have none)"
  CUSTOMER ||--o{ ORDER : "places (optional, guest orders have none)"
  ORDER ||--o{ ORDER_ITEM : "contains"
  PRODUCT ||--o{ ORDER_ITEM : "referenced by"
  ORDER ||--|| PAYMENT : "is paid by"
```

## Key flows

### Browse and add to cart

```mermaid
sequenceDiagram
  participant S as Shopper
  participant W as Ceramics Storefront
  participant A as Ceramics API

  S->>W: Browse catalog / filter by category
  W->>A: GET /products?category=...
  A-->>W: product list
  S->>W: Add product to cart
  W->>A: POST /carts/{cartId}/items
  A-->>W: updated cart
```

### Guest or signed-in checkout

```mermaid
sequenceDiagram
  participant S as Shopper
  participant W as Ceramics Storefront
  participant A as Ceramics API
  participant T as Thunder Auth
  participant P as Payment Provider
  participant E as Email Provider

  opt Shopper signs in
    S->>W: Sign in
    W->>T: OIDC + PKCE
    T-->>W: ID/access token
  end
  S->>W: Submit checkout (shipping + card details)
  W->>A: POST /orders (cart, contact, guest or bearer token)
  A->>P: Create payment charge
  P-->>A: payment result
  A->>E: Send order confirmation email
  A-->>W: order created (status: placed)
  W-->>S: Order confirmation screen
```

### Admin manages catalog and fulfillment

```mermaid
sequenceDiagram
  participant Adm as Store Admin
  participant W as Ceramics Storefront
  participant T as Thunder Auth
  participant A as Ceramics API

  Adm->>W: Sign in
  W->>T: OIDC + PKCE
  T-->>W: ID/access token (admin role)
  Adm->>W: Create/edit product, adjust stock
  W->>A: POST/PUT /products (bearer token)
  A-->>W: updated product
  Adm->>W: View incoming orders
  W->>A: GET /orders
  A-->>W: order list
  Adm->>W: Update order status (packed/shipped/delivered)
  W->>A: PATCH /orders/{orderId}/status
  A-->>W: updated order
```