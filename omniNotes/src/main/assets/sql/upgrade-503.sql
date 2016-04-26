--
-- Converts 'notes' table into a virtual table to implement real full-text search
--

ALTER TABLE notes RENAME TO notes_tmp;
CREATE
	VIRTUAL TABLE notes USING fts4
	(
		creation INTEGER PRIMARY KEY,
		last_modification INTEGER,
		title TEXT,
		content TEXT,
		archived INTEGER,
		trashed INTEGER,
		alarm INTEGER DEFAULT null,
        reminder_fired INTEGER,
		recurrence_rule TEXT,
		latitude REAL,
		longitude REAL,
		address TEXT,
		category_id INTEGER DEFAULT null,
		locked INTEGER,  
		checklist  INTEGER   
	);
INSERT INTO notes(creation, last_modification, title, content, archived, trashed, alarm, reminder_fired,
    recurrence_rule, latitude, longitude, address, category_id, locked, checklist)
SELECT creation, last_modification, title, content, archived, trashed, alarm, reminder_fired, recurrence_rule,
    latitude, longitude, address, category_id, locked, checklist
FROM notes_tmp;
DROP TABLE notes_tmp; 
