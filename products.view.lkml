view: products {
  sql_table_name: demo_db.products ;;

  filter: category_to_count {
    label: "Type of category to count"
    suggest_dimension: category
  }

  filter: brand_selector {      #not working?
    label: "Brand Selector"
    suggest_dimension: brand
  }

#    dimension: inventory_item_test {
#      type: number
#      sql: ${inventory_items.cost} ;;
#    }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  dimension: brand_comparitor {           #not working??
    sql:
    CASE
      WHEN {% condition brand_selector %} ${products.brand} {% endcondition %}  --get rid of substitution syntax around filter and works
      THEN ${products.brand}
      ELSE 'All Other Brands'
    END ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }

  measure: sum_cost {       #sum_price of products
    type:  sum
    sql: ${retail_price} ;;
  }

  measure: cheapest_product {         ##returns cheapest product
    type:  min
    sql:  ${retail_price} ;;
    drill_fields: [id, item_name, brand, category]
  }

  measure: priciest_product {     ##returns most epensive product
    type:  max
    sql:  ${retail_price} ;;
    drill_fields: [id, item_name, brand, category]
  }

  measure: max_rank {   ##returns highest ranking product/brand/category
    type:  max
    sql: ${rank} ;;
    drill_fields: [id, item_name, brand, category]
  }

  measure: min_rank {               ##returns lowest ranking item
    type: min
    sql:${rank} ;;
    drill_fields: [id, item_name, brand, category]
  }

  measure: category_count {
    type: sum
    sql: CASE WHEN {% condition category_to_count %} products.category  {% endcondition %}
          THEN 1 ELSE NULL END ;;
  }
}
