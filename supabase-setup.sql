-- Nieuwjaarsquiz Database Schema
-- Voer dit uit in Supabase SQL Editor (supabase.com → SQL Editor → New Query)

-- Tabel voor game sessies
CREATE TABLE game_sessions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    code VARCHAR(4) NOT NULL UNIQUE,
    status VARCHAR(20) DEFAULT 'lobby', -- lobby, playing, finished
    current_question INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabel voor spelers
CREATE TABLE players (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    session_id UUID REFERENCES game_sessions(id) ON DELETE CASCADE,
    name VARCHAR(30) NOT NULL,
    score INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabel voor antwoorden
CREATE TABLE answers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    session_id UUID REFERENCES game_sessions(id) ON DELETE CASCADE,
    player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    question_index INTEGER NOT NULL,
    answer INTEGER NOT NULL,
    time_left INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(session_id, player_id, question_index)
);

-- Enable Row Level Security (maar laat alles toe voor deze simpele app)
ALTER TABLE game_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE players ENABLE ROW LEVEL SECURITY;
ALTER TABLE answers ENABLE ROW LEVEL SECURITY;

-- Policies: iedereen mag lezen/schrijven (voor een party game is dit OK)
CREATE POLICY "Allow all on game_sessions" ON game_sessions FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all on players" ON players FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all on answers" ON answers FOR ALL USING (true) WITH CHECK (true);

-- Enable Realtime voor alle tabellen
ALTER PUBLICATION supabase_realtime ADD TABLE game_sessions;
ALTER PUBLICATION supabase_realtime ADD TABLE players;
ALTER PUBLICATION supabase_realtime ADD TABLE answers;

-- Index voor snelle lookups
CREATE INDEX idx_sessions_code ON game_sessions(code);
CREATE INDEX idx_players_session ON players(session_id);
CREATE INDEX idx_answers_session ON answers(session_id);

-- Function om score te verhogen
CREATE OR REPLACE FUNCTION increment_score(player_id UUID, points INTEGER)
RETURNS void AS $$
BEGIN
    UPDATE players SET score = score + points WHERE id = player_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
