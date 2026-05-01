def init_db -> None:
  
with get_db() as conn:
       conn.executescript(_SCHEMA)
       conn.commit()