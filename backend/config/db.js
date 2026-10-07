import { Client } from "pg";

let client;

async function connectToPostgres() {
try {
client = new Client({
user: process.env.PG_USER,
host: process.env.PG_HOST,
database: process.env.PG_DATABASE,
password: process.env.PG_PASSWORD,
port: Number(process.env.PG_PORT),
ssl: {
rejectUnauthorized: false,
},
});


await client.connect();

console.log("Connected to PostgreSQL");


} catch (error) {
console.error("Error connecting to PostgreSQL:", error);
throw error;
}
}

async function disconnectFromPostgres() {
try {
if (client) {
await client.end();
console.log("Disconnected from PostgreSQL");
}
} catch (error) {
console.error("Error disconnecting from PostgreSQL:", error);
}
}

export {
client,
connectToPostgres,
disconnectFromPostgres,
};
