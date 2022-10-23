{{ config(
    post_hook='alter table {{ this }} add primary key (dim_date_key)',
    tags=["carmen_sightings", "mart"]
  )
}}

-- still need to find out how to inject variables '{{ var("CALENDAR_START_DATE") }}' and '{{ var("CALENDAR_END_DATE") }}'
with date_dimension as (
    {{ dbt_date.get_date_dimension('1985-04-23', '2022-08-20') }}
)
, ref_unknown_value as (
	select *
	  from {{ ref('ref_unknown_value') }}
)
, calendar as (
    select to_char(date_day, 'yyyymmdd')::int as dim_date_key
          ,*
      from date_dimension
)
, unknown_record as (
    SELECT dim_date_key
          ,date_day
          ,prior_date_day
          ,next_date_day
          ,prior_year_date_day
          ,prior_year_over_year_date_day
          ,day_of_week
          ,day_of_week_name
          ,day_of_week_name_short
          ,day_of_month
          ,day_of_year
          ,week_start_date
          ,week_end_date
          ,prior_year_week_start_date
          ,prior_year_week_end_date
          ,week_of_year
          ,iso_week_start_date
          ,iso_week_end_date
          ,prior_year_iso_week_start_date
          ,prior_year_iso_week_end_date
          ,iso_week_of_year
          ,prior_year_week_of_year
          ,prior_year_iso_week_of_year
          ,month_of_year
          ,month_name
          ,month_name_short
          ,month_start_date
          ,month_end_date
          ,prior_year_month_start_date
          ,prior_year_month_end_date
          ,quarter_of_year
          ,quarter_start_date
          ,quarter_end_date
          ,year_number
          ,year_start_date
          ,year_end_date
      from calendar

    union all
    
    select unknown_key::int
          ,null
          ,unknown_date
          ,unknown_date
          ,unknown_date
          ,unknown_date
          ,unknown_integer
          ,unknown_text
          ,unknown_text
          ,unknown_integer
          ,unknown_integer
          ,unknown_date
          ,unknown_date
          ,unknown_date
          ,unknown_date
          ,unknown_integer
          ,unknown_date
          ,unknown_date
          ,unknown_date
          ,unknown_date
          ,unknown_integer
          ,unknown_integer
          ,unknown_integer
          ,unknown_integer
          ,unknown_text
          ,unknown_text
          ,unknown_date
          ,unknown_date
          ,unknown_date
          ,unknown_date
          ,unknown_integer
          ,unknown_date
          ,unknown_date
          ,unknown_integer
          ,unknown_date
          ,unknown_date
      from ref_unknown_value
)
select *
  from unknown_record
 order by dim_date_key