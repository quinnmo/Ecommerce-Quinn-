view: user_order_facts {
    derived_table: {
      sql:SELECT
          o.user_id,
          o.id as order_id,
          o.created_at,
          min(o.created_at) as first_order,
          max(NULLIF(o.created_at, 0)) as latest_order,
          DATEDIFF(MAX(NULLIF(o.created_at,0)),MIN(NULLIF(o.created_at,0))) AS days_as_customer,
          SUM(oi.sale_price) as lifetime_revenue
          FROM demo_db.orders o
          JOIN demo_db.order_items oi ON o.id = oi.order_id
          GROUP BY o.user_id
          ;;
    }

    dimension: user_id {
      type: number
      primary_key: yes
      sql: ${TABLE}.user_id ;;
    }

    dimension: order_id {
      type: number
      sql:  ${TABLE}.order_id ;;
    }

    dimension: created_at {
      type: date
      sql: ${TABLE}.created_at ;;
    }

    dimension: first_order {
      type: date
      sql: ${TABLE}.first_order ;;
    }

    dimension: latest_order {
      type: date
      sql: ${TABLE}.latest_order ;;
    }

    dimension: days_as_customer {
      type: number
      sql: ${TABLE}.days_as_customer ;;
    }

    dimension: lifetime_revenue {
      type: number
      sql: ${TABLE}.lifetime_revenue ;;
      value_format: "0.00"
    }

    dimension:  order_count{
      type: number
      sql: ${TABLE}.order_count ;;
    }

    dimension: one_time_user {
      type: yesno
      sql: ${order_count} = 1  ;;
    }

    dimension: long_time_customers{       #above average time as customer
      type: yesno
      sql: ${days_as_customer} > 87.2254 ;;
    }

#     dimension: life_time_revenue_tier{
#       type:
#     }

    measure: count {
      type: count
      drill_fields: [details*]
    }

    measure: average_days_as_customer {
      type: average
      sql: ${days_as_customer} ;;
    }

    measure: avg_lifetime_revenue {
      type: average
      sql: ${lifetime_revenue} ;;
      value_format: "0.00"
    }


    set: details {
      fields: [user_id, order_id, created_at]
    }
    }



    # # You can specify the table name if it's different from the view name:
    # sql_table_name: my_schema_name.tester ;;
    #
    # # Define your dimensions and measures here, like this:
    # dimension: user_id {
    #   description: "Unique ID for each user that has ordered"
    #   type: number
    #   sql: ${TABLE}.user_id ;;
    # }
    #
    # dimension: lifetime_orders {
    #   description: "The total number of orders for each user"
    #   type: number
    #   sql: ${TABLE}.lifetime_orders ;;
    # }
    #
    # dimension_group: most_recent_purchase {
    #   description: "The date when each user last ordered"
    #   type: time
    #   timeframes: [date, week, month, year]
    #   sql: ${TABLE}.most_recent_purchase_at ;;
    # }
    #
    # measure: total_lifetime_orders {
    #   description: "Use this for counting lifetime orders across many users"
    #   type: sum
    #   sql: ${lifetime_orders} ;;
    # }


# view: user_order_facts_pdt {
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
