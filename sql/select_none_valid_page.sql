select "update page set page_lastest=", r.rev_id, " where page_id=", p.page_id from page p, revision r
where p.page_latest not in (select rev_id from revision) and page_latest = r.rev_parent_id