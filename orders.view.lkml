view: orders {
  sql_table_name: demo_db.orders ;;

  filter: last_day {
    type: date_time
  }

  filter: date_filter {
    type: date
    default_value: "last week"
    }

  dimension: date_test {
    type: yesno
    sql: {% condition date_filter %} ${created_date} {% endcondition %}
          AND {% condition date_filter %} ${users.created_week} {% endcondition %} ;;
  }


  dimension: last_day_group {
    type: yesno
    sql: {% condition last_day %} ${created_raw} {% endcondition %};;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: brand_era {                  ##this company rebranded in 2004!!...
    case: {
      when: {
        sql: ${created_year} < 2004 ;;
        label: " pre-rebrand"
      }
      when: {
        sql: ${created_year} >= 2004 ;;
        label: "post-rebrand"
      }
      else: "unknown"
    }
  }

  dimension: total_amount_of_order {
    type:  number
    sql: (SELECT SUM(order_items.sale_price)
      FROM order_items
      WHERE order_items.order_id = orders.id) ;;
    drill_fields: [details*]
    value_format: "0.00"
  }

  dimension: total_cost_of_order{
    type: number
    sql: (SELECT SUM(inventory_items.cost)
      FROM order_items
      LEFT JOIN inventory_items ON order_items.inventory_item_id = inventory_items.id
      WHERE order_items.order_id = orders.id) ;;
    value_format: "0.00"
  }

  dimension: net_order_profit {
    type: number
    value_format: "$0.00"
    sql: ${total_amount_of_order} - ${total_cost_of_order} ;;
  }
  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id, order_items.count]
  }

  measure: completed_order_count {      #count of completed orders
    type:  count
    filters: {
      field:  status
      value: " complete"
    }
    drill_fields: [id, created_date, users.last_name, users.first_name, users.id, order_items.count]
  }

  measure: average_order_profit {
    type: average
    sql: ${net_order_profit} ;;
    drill_fields: [details*]
    value_format: "0.00"
  }

  measure: total_net_profit {         ##if unknown field error make sure to join inventory_items
    type:  sum
    sql: ${net_order_profit} ;;
    drill_fields: [details*]
    value_format: "0.00"
  }

  measure: total_net_revenue {
    type: sum
    sql: ${total_amount_of_order} ;;
    value_format: "0.00"
  }

  measure: total_expenses {
    type: sum
    sql: ${total_cost_of_order} ;;
    value_format: "0.00"
  }

  measure: last_day_count {
    type: count
    filters: {
      field: last_day_group
      value: "yes"
    }
  }

#   measure: filter_measure {
#     type: count
#     filters: {
#       field: id
#       value: "10"
#     }
#   }

# DRILL SET
  set: details {
    fields: [
      id,
      created_time]
  }
  }
