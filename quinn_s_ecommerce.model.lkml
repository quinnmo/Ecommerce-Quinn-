connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"


map_layer: ca_cities_map {
  format: topojson
  file: "Cities2015.json"
  property_key: "NAME"
}

datagroup: orders_datagroup {
  sql_trigger: SELECT MAX(id) FROM orders ;;      #include etl??
  max_cache_age: "24 hours"
}

datagroup: users_datagroup {
  sql_trigger: SELECT MAX(id) FROM users ;;
  max_cache_age: "24 hours"
}

persist_with: orders_datagroup

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
      type: left_outer
      sql_on: ${inventory_items.product_id} = ${products.id} ;;
      relationship: many_to_one
   }
  }


explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} AND ${orders.status} = "complete";;
    relationship: many_to_one
  }
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: user_order_facts {
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders.user_id} = ${user_order_facts.user_id} ;;
  }
}

 explore: orders {
   sql_always_where: ${created_year} >= 1980;;
   join: users {
      type: left_outer
      sql_on: ${orders.user_id} = ${users.id} ;;
      relationship: many_to_one
   }
 }

 explore: products {}

 explore: schema_migrations {}

 explore: user_data {
   join: users {
     type: left_outer
     sql_on: ${user_data.user_id} = ${users.id} ;;
     relationship: many_to_one
   }
   persist_with: users_datagroup
 }

explore: native_dt {}

 explore: users {}

 explore: users_nn {}

 explore: user_order_facts {}

 explore: mvp_customers {}
