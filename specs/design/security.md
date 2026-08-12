# Handmade Ceramics Store — Security Design

## Roles → permissions

## Authentication (Thunder)

- Sign-in is optional for Shoppers (guest checkout is allowed) and required for
Store Admin. Both `ceramics-webapp` and `ceramics-api` declare the SAME
`thunder-app` dependency, named **`user-auth`**, tying browser sign-in to the
bearer tokens the API validates.
- Scopes: default `openid profile email`.
- `ceramics-webapp` performs OIDC + PKCE against Thunder to obtain a token for
signed-in flows (Shopper order history, all Admin screens); guest checkout
and anonymous catalog browsing proceed with no token.
- `ceramics-api` sits behind the platform's API gateway, which validates any
presented token and injects identity headers; endpoints that require a role
(admin-only or "my orders") reject an absent/invalid token with `401`, and a
valid token lacking the needed role with `403`.

## Role resolution

- The gateway injects `X-User-Id` (and the validated token's claims) on every
authenticated call. `ceramics-api` reads the role claim from the token to
distinguish **Store Admin** from a plain signed-in **Shopper**.
- An unmapped or missing role on an endpoint that requires one is denied by
default (`403`); endpoints that allow guests (catalog browsing, guest
checkout) accept requests with no token at all.