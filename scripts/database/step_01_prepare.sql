begin;

drop schema if exists dormouse cascade;
drop user if exists dormouse;

create user dormouse with password 'LetMeIn';
create schema authorization dormouse;

commit;
