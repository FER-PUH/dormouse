begin;

grant all privileges on                  schema dormouse to dormouse;
grant all privileges on all tables    in schema dormouse to dormouse;
grant all privileges on all sequences in schema dormouse to dormouse;

commit;
