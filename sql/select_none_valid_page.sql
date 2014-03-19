select "update page set page_lastest=", r.rev_id, " where page_id=", p.page_id from page p, revision r
where p.page_id = r.rev_page and p.page_latest != r.rev_id and p.page_latest = r.rev_parent_id and r.rev_id = (select rev_id from revision r2 where r2.rev_page=p.page_id and r2.rev_parent_id=p.page_latest  order by rev_id asc limit 1);
