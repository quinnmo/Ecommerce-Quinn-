view: mvp_customers {       ##not working :(
  derived_table: {
    sql:
      SELECT
      user_id,
      lifetime_revenue,
      days_as_customer
      FROM ${user_order_facts.SQL_TABLE_NAME} AS user_order_facts
      WHERE lifetime_revenue >= 1000.00
      GROUP BY user_id ;;
      sql_trigger_value: SELECT FLOOR((UNIX_TIMESTAMP(NOW()) - 60*60*18)/(60*60*24)) ;;
      indexes: ["user_id"]
  }

 dimension: user_id {
  description: "Unique ID for each user that has ordered"
  primary_key: yes
  type: number
   sql: ${TABLE}.user_id ;;
   }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

dimension: days_as_customer {
  type: number
  sql: ${TABLE}.days_as_customer ;;
}

dimension: long_time_customer {
     type: yesno
     sql: ${TABLE}.days_as_customer > 87.2254 ;;
   }

}

# view: mvp_customers {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
