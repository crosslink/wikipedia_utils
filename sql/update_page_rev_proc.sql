DELIMITER //

DROP PROCEDURE IF EXISTS update_page_rev_proc//

CREATE PROCEDURE update_page_rev_proc()
BEGIN
DECLARE n INT DEFAULT 0;
DECLARE i INT DEFAULT 0;
DECLARE revCount INT DEFAULT 0;
DECLARE pageId INT DEFAULT 0;
DECLARE pageLatest INT DEFAULT 0;
DECLARE revParent INT DEFAULT 0;
DECLARE revId INT DEFAULT 0;

SELECT COUNT(*) FROM page INTO n;
SET i=0;

--to slow with this method
--1496848

WHILE i<n DO 
  SET pageId = (SELECT page_id from page LIMIT i,1);
  SET revId = (select max(rev_id) from revision where rev_page=pageId group by rev_page);
 SELECT concat("#", cast(i as char)), cast(pageId as char)' updating latest revision id of page';
  UPDATE page SET page_latest=revId where page_id=pageId;
        COMMIT;
  SET i = i + 1;
END WHILE;
END;
//

DELIMETER ;

