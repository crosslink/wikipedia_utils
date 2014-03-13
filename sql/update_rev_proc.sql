DELIMITER //

DROP PROCEDURE IF EXISTS update_rev_proc//

CREATE PROCEDURE update_rev_proc()
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

WHILE i<n DO 
  SET pageId = (SELECT page_id from page LIMIT i,1);
  SET revCount = (select count(*) from revision where rev_id = (select page_latest from page where page_id=pageID));
  IF revCount = 0 THEN
  	SELECT cast(pageId as char)' contains not valid revision id';
  	SET revCount = (select count(*) from revision where rev_page=pageId);
  	IF revCount > 0 THEN
  	  SET pageLatest = (SELECT page_latest from page where page_id=pageId);
  	  IF pageLatest > 0 THEN
		  SET revId = (select rev_id from revision where rev_page=pageId and rev_parent_id=pageLatest);
		  UPDATE page SET page_latest = (select rev_id from revision where rev_parent_id>0 and rev_parent_id= pageLatest);
	  END IF;
	END IF;
  END IF;
  SET i = i + 1;
END WHILE;
END;
//

DELIMETER ;
//