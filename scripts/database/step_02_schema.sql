begin;

--

create table if not exists dormouse."Year"
    ( "id"           serial primary key
    , "name"         text   not null
    , "dateCreated"  date   not null
    , "dateModified" date   not null
    );

--

create table if not exists dormouse."User"
    ( "id" 		     serial  primary key

    , "jmbag" 	     text    not null
    , "email" 	     text    not null
    , "password"     text    not null
    , "name" 	     text    not null
    , "surname"      text    not null
    , "admin"        boolean not null

    , "dateCreated"  date    not null
    , "dateModified" date    not null
    );

--

create table if not exists dormouse."Role"
    ( "id"           serial primary key
    , "yearId"       int    not null
    , "userId"       int    not null

    , "role"         text   not null

    , "dateCreated"  date   not null
    , "dateModified" date   not null
    );

alter table dormouse."Role"
add constraint "fk_Role_yearId"
    foreign key ("yearId") references dormouse."Year" ("id");

alter table dormouse."Role"
add constraint "fk_Role_userId"
    foreign key ("userId") references dormouse."User" ("id");

--

create table if not exists dormouse."Task"
    ( "id"           serial  primary key
    , "yearId"       int     not null

    , "title"        text    not null
    , "description"  text    not null

    , "published"    boolean not null

    , "dateCreated"  date    not null
    , "dateModified" date    not null
    );

alter table dormouse."Task"
add constraint "fk_Task_yearId"
    foreign key ("yearId") references dormouse."Year" ("id");

--

create table if not exists dormouse."Attachment"
    ( "id"           serial primary key
    , "taskId"       int    not null

    , "name"         text   not null
    , "description"  text
    , "payload"      bytea  not null
    
    , "dateCreated"  date   not null
    , "dateModified" date   not null
    );

alter table dormouse."Attachment"
add constraint "fk_Attachment_taskId"
    foreign key ("taskId") references dormouse."Task" ("id");

--

create table if not exists dormouse."Element"
    ( "id"           serial           primary key
    , "taskId"       int              not null

    , "points"       double precision not null
    , "fileName"     text             not null
    , "fileType"     text             not null

    , "dateCreated"  date             not null
    , "dateModified" date             not null
    );

alter table dormouse."Element"
add constraint "fk_Element_taskId"
    foreign key ("taskId") references dormouse."Task" ("id");

--

create table if not exists dormouse."Deadline"
    ( "id"           serial           primary key
    , "taskId"       int              not null

    , "deadline"     timestamp        not null
    , "pointsFactor" double precision not null

    , "dateCreated"  date             not null
    , "dateModified" date             not null
    );

alter table dormouse."Deadline"
add constraint "fk_Deadline_taskId"
    foreign key ("taskId") references dormouse."Task" ("id");

--

create table if not exists dormouse."Submission"
    ( "id"           serial  primary key
    , "userId"       int     not null
    , "deadlineId"   int     not null

    , "locked"       boolean not null

    , "dateCreated"  date    not null
    , "dateModified" date    not null
    );

alter table dormouse."Submission"
add constraint "fk_Submission_userId"
    foreign key ("userId") references dormouse."User" ("id");

alter table dormouse."Submission"
add constraint "fk_Submission_deadlineId"
    foreign key ("deadlineId") references dormouse."Deadline" ("id");

--

create table if not exists dormouse."File"
    ( "id"           serial primary key
    , "elementId"    int    not null
    , "submissionId" int    not null
 
    , "payload"      bytea  not null

    , "dateCreated"  date   not null
    , "dateModified" date   not null
    );

alter table dormouse."File"
add constraint "fk_File_elementId"
    foreign key ("elementId") references dormouse."Element" ("id");

alter table dormouse."File"
add constraint "fk_File_submissionId"
    foreign key ("submissionId") references dormouse."Submission" ("id");

--

create table if not exists dormouse."Review"
    ( "id"           serial  primary key
    , "reviewerId"   int     not null
    , "submissionId" int     not null

    , "published"    boolean not null
    
    , "dateCreated"  date    not null
    , "dateModified" date    not null
    );

alter table dormouse."Review"
add constraint "fk_Review_reviewerId"
    foreign key ("reviewerId") references dormouse."User" ("id");

alter table dormouse."Review"
add constraint "fk_Review_submissionId"
    foreign key ("submissionId") references dormouse."Submission" ("id");

--

create table if not exists dormouse."FileReview"
    ( "id"           serial           primary key
    , "fileId"       int              not null
    , "reviewId"     int              not null
    
    , "points"       double precision not null
    , "content"      text             not null

    , "dateCreated"  date             not null
    , "dateModified" date             not null
    );

alter table dormouse."FileReview"
add constraint "fk_FileReview_fileId"
    foreign key ("fileId") references dormouse."File" ("id");

alter table dormouse."FileReview"
add constraint "fk_FileReview_reviewId"
    foreign key ("reviewId") references dormouse."Review" ("id");

--

commit;
