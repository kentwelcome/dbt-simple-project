{{ config(materialized='view') }}

with raw as (
    select * from read_csv_auto('data/steam_top_games_2026.csv', header=true, sample_size=-1)
)

select
    app_id,
    name,
    try_cast(release_date as date) as release_date,
    coming_soon,
    cast(price_usd as double) as price_usd,
    is_free,
    cast(discount_pct as integer) as discount_pct,
    developer,
    publisher,
    genres,
    categories,
    tags,
    platforms_win,
    platforms_mac,
    platforms_linux,
    try_cast(metacritic_score as integer) as metacritic_score,
    cast(recommendations as bigint) as recommendations,
    cast(positive_reviews as bigint) as positive_reviews,
    cast(negative_reviews as bigint) as negative_reviews,
    estimated_owners,
    cast(avg_playtime_forever as integer) as avg_playtime_forever,
    cast(avg_playtime_2weeks as integer) as avg_playtime_2weeks,
    cast(median_playtime as integer) as median_playtime,
    cast(peak_ccu as integer) as peak_ccu,
    cast(required_age as integer) as required_age,
    cast(dlc_count as integer) as dlc_count,
    cast(achievements as integer) as achievements,
    short_description,
    header_image,
    case
        when (positive_reviews + negative_reviews) > 0
        then positive_reviews::double / (positive_reviews + negative_reviews)
        else null
    end as positive_review_ratio
from raw
