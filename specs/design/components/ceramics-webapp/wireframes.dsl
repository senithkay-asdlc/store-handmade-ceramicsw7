// Handmade Ceramics Store — storefront + admin console

screen Catalog "Shopper browses and filters the product catalog"
  navbar "Ceramics Co. | Shop -> Catalog | Cart -> Cart | Sign in -> SignIn"
  row
    heading "Handmade Ceramics"
    right
    search "Search ceramics…"
    select "Category: All"
  row
    card "Blue Glaze Mug | $24 | In stock" -> ProductDetail
    card "Speckled Bowl Set | $58 | In stock" -> ProductDetail
    card "Terracotta Vase | $42 | Only 2 left" -> ProductDetail
    card "Matte Black Plate | $19 | Out of stock" -> ProductDetail

screen ProductDetail "Shopper views full detail for one product before buying"
  navbar "Ceramics Co. | Shop -> Catalog | Cart -> Cart | Sign in -> SignIn"
  breadcrumb "Shop / Stoneware / Blue Glaze Mug"
  split 60/40
    left
      image "Blue Glaze Mug photo" 400x300
      text "Hand-thrown stoneware mug with a hand-mixed blue glaze. Holds 12oz. Dishwasher safe."
    right
      heading "Blue Glaze Mug"
      text "$24.00"
      badge "In stock" success
      select "Quantity: 1"
      button "Add to cart" primary -> Cart

screen Cart "Shopper reviews and adjusts items before checking out"
  navbar "Ceramics Co. | Shop -> Catalog | Cart -> Cart | Sign in -> SignIn"
  heading "Your Cart"
  table "Product | Price | Qty | Subtotal"
    row "Blue Glaze Mug | $24.00 | 1 | $24.00"
    row "Speckled Bowl Set | $58.00 | 1 | $58.00"
  row
    right
    text "Total: $82.00"
  row
    right
    button "Continue shopping" -> Catalog
    button "Checkout" primary -> Checkout

screen Checkout "Shopper pays, as a guest or signed in"
  navbar "Ceramics Co. | Shop -> Catalog | Cart -> Cart | Sign in -> SignIn"
  heading "Checkout"
  text "Guest checkout — no account needed. Already have an account? Sign in for order history."
  input "Email — for your order confirmation"
  textarea "Shipping address"
  heading "Payment"
  input "Card number"
  row
    input "Expiry"
    input "CVC"
  row
    right
    button "Back to cart" -> Cart
    button "Place order — $82.00" primary -> OrderConfirmation

screen OrderConfirmation "Shopper sees confirmation right after paying"
  navbar "Ceramics Co. | Shop -> Catalog | Cart -> Cart | Sign in -> SignIn"
  heading "Thank you for your order!"
  badge "Placed" success
  text "Order #10482 — a confirmation email is on its way to you@example.com"
  table "Product | Qty | Price"
    row "Blue Glaze Mug | 1 | $24.00"
    row "Speckled Bowl Set | 1 | $58.00"
  text "Total: $82.00"
  button "Back to shop" -> Catalog

screen SignIn "Shopper or admin signs in via Thunder"
  navbar "Ceramics Co. | Shop -> Catalog | Cart -> Cart | Sign in -> SignIn"
  heading "Sign in"
  text "Sign in to view your order history, or to access the admin console."
  input "Email"
  input "Password"
  button "Sign in with Thunder" primary -> MyOrders

screen MyOrders "Signed-in shopper views their own order history and status"
  navbar "Ceramics Co. | Shop -> Catalog | Cart -> Cart | My Orders -> MyOrders | Sign in -> SignIn"
  heading "My Orders"
  table "Order | Placed | Total | Status" -> OrderConfirmation
    row "#10482 | Aug 10 | $82.00 | Shipped"
    row "#10391 | Jul 28 | $24.00 | Delivered"

screen AdminCatalog "Admin manages the product catalog and inventory"
  navbar "Ceramics Co. Admin"
  sidebar "Catalog -> AdminCatalog | Orders -> AdminOrders | Settings"
  row
    heading "Catalog"
    right
    button "New product" primary -> AdminProductEdit
  table "Product | Category | Price | Stock | Status" -> AdminProductEdit
    row "Blue Glaze Mug | Stoneware | $24.00 | 18 | Active"
    row "Speckled Bowl Set | Stoneware | $58.00 | 6 | Active"
    row "Matte Black Plate | Tableware | $19.00 | 0 | Active"

screen AdminProductEdit "Admin creates or edits one product, including stock"
  navbar "Ceramics Co. Admin"
  sidebar "Catalog -> AdminCatalog | Orders -> AdminOrders | Settings"
  breadcrumb "Catalog / Blue Glaze Mug"
  heading "Edit Product"
  input "Name — Blue Glaze Mug"
  textarea "Description"
  row
    input "Price (cents) — 2400"
    select "Category: Stoneware"
  input "Stock quantity — 18"
  checkbox "Active — visible in catalog" active
  row
    right
    button "Cancel" -> AdminCatalog
    button "Save product" primary -> AdminCatalog

screen AdminOrders "Admin views incoming orders and updates fulfillment status"
  navbar "Ceramics Co. Admin"
  sidebar "Catalog -> AdminCatalog | Orders -> AdminOrders | Settings"
  row
    heading "Orders"
    right
    select "Status: All"
  table "Order | Customer | Total | Status | Placed" -> AdminOrderDetail
    row "#10482 | jane@example.com | $82.00 | Shipped | Aug 10"
    row "#10475 | guest checkout | $19.00 | Placed | Aug 9"
    row "#10391 | jane@example.com | $24.00 | Delivered | Jul 28"

screen AdminOrderDetail "Admin updates one order's fulfillment status"
  navbar "Ceramics Co. Admin"
  sidebar "Catalog -> AdminCatalog | Orders -> AdminOrders | Settings"
  breadcrumb "Orders / #10482"
  row
    heading "Order #10482"
    badge "Shipped" info
  text "jane@example.com — placed Aug 10"
  table "Product | Qty | Price"
    row "Blue Glaze Mug | 1 | $24.00"
    row "Speckled Bowl Set | 1 | $58.00"
  select "Update status: Delivered"
  row
    right
    button "Save status" primary -> AdminOrders
