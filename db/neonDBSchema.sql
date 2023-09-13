CREATE TABLE time_control (
  id smallint PRIMARY KEY NOT NULL,
  initial_minutes smallint,
  initial_seconds smallint,
  increment smallint
);

CREATE TABLE result (
  id int PRIMARY KEY NOT NULL,
  name varchar(25) NOT NULL
);

CREATE TABLE friendship_status (
  id int PRIMARY KEY NOT NULL,
  name varchar(25) NOT NULL
);

CREATE TABLE player (
  id uuid PRIMARY KEY NOT NULL,
  name varchar(25) NOT NULL,
  email varchar(40) NOT NULL
);

CREATE TABLE team (
  id uuid PRIMARY KEY NOT NULL,
  player_id uuid NOT NULL,
  name varchar(25) NOT NULL,
  piece_types varchar(150),
  time_control_id smallint NOT NULL,
  categories varchar(512),
  CONSTRAINT fk_time_control FOREIGN KEY (time_control_id) REFERENCES time_control(id)
);

CREATE TABLE game (
  id uuid PRIMARY KEY NOT NULL,
  white_player_id uuid NOT NULL,
  black_player_id uuid NOT NULL,
  final_fen varchar(100),
  moves varchar(255),
  white_team_id uuid,
  black_team_id uuid,
  result_id int REFERENCES result(id) NOT NULL,
  start_time timestamp,
  end_time timestamp,
  time_control_id int,
  CONSTRAINT fk_black_team FOREIGN KEY (black_team_id) REFERENCES team(id),
  CONSTRAINT fk_white_player FOREIGN KEY (white_player_id) REFERENCES player(id),
  CONSTRAINT fk_black_player FOREIGN KEY (black_player_id) REFERENCES player(id),
  CONSTRAINT fk_white_team FOREIGN KEY (white_team_id) REFERENCES team(id)
);

CREATE TABLE friendship (
  requester_id uuid NOT NULL,
  addressee_id uuid NOT NULL,
  creation_date date,
  status int,
  id uuid PRIMARY KEY NOT NULL,
  CONSTRAINT fk_requester FOREIGN KEY (requester_id) REFERENCES player(id),
  CONSTRAINT fk_addressee FOREIGN KEY (addressee_id) REFERENCES player(id),
  CONSTRAINT fk_friendship_status FOREIGN KEY (status) REFERENCES friendship_status(id)
);

CREATE INDEX idx_requester ON friendship (requester_id);
CREATE INDEX idx_addressee ON friendship (addressee_id);

CREATE TABLE player_time_control_rating (
  player_id uuid NOT NULL,
  time_control_id int NOT NULL,
  rating smallint,
  CONSTRAINT fk_player_time_control FOREIGN KEY (player_id) REFERENCES player(id),
  CONSTRAINT fk_player_time_control_rating_time_control FOREIGN KEY (time_control_id) REFERENCES time_control(id)
);

CREATE INDEX idx_player_rating ON player_time_control_rating (player_id);
CREATE INDEX idx_time_control_rating ON player_time_control_rating (time_control_id);
