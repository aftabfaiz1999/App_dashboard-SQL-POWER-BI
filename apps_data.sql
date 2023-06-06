with ac as (
select a.apps_title,a.id,c.category_id from apps as a
inner join apps_categories as c
on a.id=c.app_id
)
,

tc as (

select a.apps_title,c.title,a.id from ac as a
inner join categories as c
on a.category_id=c.id

)

,

ar as (

select a.apps_title,a.title,a.id,r.rating,r.posted_at from tc as a
inner join reviews as r
on a.id=r.app_id
)

,--exec sp_rename 'pricing_plans.title', 'plane_type','column';--

kl as (

select m.apps_title,m.rating,m.title,m.posted_at,p.price,p.plane_type  from ar as m
inner join pricing_plans as p
on m.id=p.app_id
)


 
select SUM(k.rating) as tot_rating,k.title as category,k.apps_title,k.price,k.plane_type,k.posted_at from kl as k
where k.plane_type is not null
group by k.title,k.apps_title,k.price,k.plane_type,k.posted_at
order by tot_rating desc
