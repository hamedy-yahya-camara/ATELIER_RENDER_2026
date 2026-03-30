import React, { useEffect, useState } from "react";

const API_URL = process.env.REACT_APP_API_URL || "";

function App() {
  const [health, setHealth] = useState(null);
  const [info, setInfo] = useState(null);

  useEffect(() => {
    fetch(`${API_URL}/health`)
      .then(res => res.json())
      .then(data => setHealth(data));

    fetch(`${API_URL}/info`)
      .then(res => res.json())
      .then(data => setInfo(data));
  }, []);

  return (
    <div style={{ fontFamily: "Arial", padding: "40px" }}>
      <h1>🚀 Flask + React + PostgreSQL</h1>
      <h2>Health</h2>
      <pre>{JSON.stringify(health, null, 2)}</pre>
      <h2>Info</h2>
      <pre>{JSON.stringify(info, null, 2)}</pre>
    </div>
  );
}

export default App;
