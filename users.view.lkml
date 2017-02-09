view: users {
  sql_table_name: public.users ;;


  dimension: primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${id} || ' ' || ${created_date} ;;
  }

  dimension: id {
#     primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: full_name {
    type: string
    sql: ${first_name} || ' ' || ${last_name} ;;
  }

  dimension: city_state {
    type: string
    sql: ${city} || ', ' || ${state} ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_num,
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: days_since_signup {
    type: number
    sql: datediff('day', ${created_date}, GETDATE()) ;;
  }

  dimension: days_since_signup_tier {
    type: tier
    tiers: [30, 60, 90, 180, 360, 720]
    style: integer
    sql: ${days_since_signup} ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [18, 30, 50, 80]
    style: integer
    sql: ${age} ;;
  }

  dimension: is_new_user {
    type: yesno
    sql: ${days_since_signup} <= 60 ;;
  }

  dimension: is_under_18 {
    type: yesno
    sql: ${age} < 18 ;;
  }

  dimension: is_new_user_number {
    type: number
    sql: CASE WHEN ${days_since_signup} <= 60  THEN 1 ELSE 0 END ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: number
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, orders.count]
  }
}
