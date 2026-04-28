with games as (
    select * from {{ ref('stg_steam_games') }}
),

scored as (
    select
        app_id,
        name,
        developer,
        publisher,
        release_date,
        price_usd,
        is_free,
        genres,
        positive_reviews,
        negative_reviews,
        positive_review_ratio,
        peak_ccu,
        recommendations,
        avg_playtime_forever
    from games
    where (positive_reviews + negative_reviews) >= 100
)

select
    *,
    row_number() over (order by positive_review_ratio desc, positive_reviews desc) as rank_by_rating,
    row_number() over (order by peak_ccu desc) as rank_by_peak_ccu
from scored
order by rank_by_rating
