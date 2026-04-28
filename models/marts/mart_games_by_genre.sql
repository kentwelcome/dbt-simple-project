with games as (
    select * from {{ ref('stg_steam_games') }}
),

exploded as (
    select
        app_id,
        name,
        trim(unnest(string_split(genres, ','))) as genre,
        price_usd,
        positive_reviews,
        negative_reviews,
        positive_review_ratio,
        peak_ccu,
        avg_playtime_forever
    from games
    where genres is not null
)

select
    genre,
    count(*) as game_count,
    round(avg(price_usd), 2) as avg_price_usd,
    sum(positive_reviews) as total_positive_reviews,
    sum(negative_reviews) as total_negative_reviews,
    round(avg(positive_review_ratio), 4) as avg_positive_review_ratio,
    sum(peak_ccu) as total_peak_ccu,
    round(avg(avg_playtime_forever), 1) as avg_playtime_minutes
from exploded
where genre <> ''
group by genre
order by game_count desc
