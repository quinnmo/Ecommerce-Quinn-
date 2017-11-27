- dashboard: test_
  title: 'Test '
  layout: newspaper
  embed_style:
    background_color: "#f6f8fa"
    show_title: true
    title_color: "#3a4245"
    show_filters_bar: false
    tile_text_color: "#3a4245"
    text_tile_text_color: ''
  elements:
  - name: Avg Lifetime Revenue
    title: Avg Lifetime Revenue
    model: quinn_s_ecommerce
    explore: user_order_facts
    type: single_value
    fields:
    - user_order_facts.avg_lifetime_revenue
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    row: 0
    col: 0
    width: 11
    height: 7
  - name: Long Time Customers
    title: Long Time Customers
    model: quinn_s_ecommerce
    explore: user_order_facts
    type: looker_pie
    fields:
    - user_order_facts.long_time_customer
    - user_order_facts.count
    fill_fields:
    - user_order_facts.long_time_customer
    sorts:
    - user_order_facts.long_time_customer
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    value_labels: legend
    label_type: labPer
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 0
    col: 12
    width: 12
    height: 7
  - title: bug test
    name: bug test
    model: quinn_s_ecommerce
    explore: orders
    type: looker_line
    fields:
    - orders.status
    - orders.average_order_profit
    - orders.created_year
    pivots:
    - orders.status
    fill_fields:
    - orders.created_year
    sorts:
    - orders.status
    - orders.created_year desc
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_series:
    - complete
    - pending
    row:
    col:
    width:
    height:
  filters:
  - name: date
    title: date
    type: date_filter
    default_value: 2017/10/11
    model: quinn_s_ecommerce
    explore: user_order_facts
    field:
    listens_to_filters: []
    allow_multiple_values: false
    required: false
