CREATE TABLE revision_token
(
  revision_token_id integer PRIMARY KEY,
  tipo character varying(1) NOT NULL,
  email character varying(200) NOT NULL,
  token character varying(100) NOT NULL,
  handle_revisado character varying(21),
  workspace_id character varying(10),
  revision_id character varying(10)
);


CREATE SEQUENCE revision_token_seq;

