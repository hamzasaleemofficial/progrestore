import pg from "pg";

const { Client } = pg;

const {
  PG_HOST,
  PG_DATABASE,
  PG_PORT = "5432",
  MASTER_PG_USER,
  MASTER_PG_PASSWORD,
  APP_PG_USER = "app_user",
  APP_PG_PASSWORD,
} = process.env;

const requiredVariables = {
  PG_HOST,
  PG_DATABASE,
  MASTER_PG_USER,
  MASTER_PG_PASSWORD,
  APP_PG_PASSWORD,
};

for (const [name, value] of Object.entries(requiredVariables)) {
  if (!value) {
    console.error(`Missing required environment variable: ${name}`);
    process.exit(1);
  }
}

const client = new Client({
  host: PG_HOST,
  database: PG_DATABASE,
  port: Number(PG_PORT),
  user: MASTER_PG_USER,
  password: MASTER_PG_PASSWORD,
  ssl: {
    rejectUnauthorized: false,
  },
  connectionTimeoutMillis: 10000,
});

async function executeFormattedQuery(sql, values) {
  const result = await client.query(sql, values);
  const statement = result.rows[0]?.statement;

  if (!statement) {
    throw new Error("Failed to prepare database statement.");
  }

  await client.query(statement);
}

async function initializeDatabase() {
  try {
    await client.connect();

    console.log("Connected to PostgreSQL for database initialization.");

    // Check whether the application role already exists.
    const roleResult = await client.query(
      "SELECT 1 FROM pg_roles WHERE rolname = $1",
      [APP_PG_USER]
    );

    if (roleResult.rowCount === 0) {
      // Create the role only if it does not exist.
      await executeFormattedQuery(
        "SELECT format('CREATE ROLE %I LOGIN PASSWORD %L', $1, $2) AS statement",
        [APP_PG_USER, APP_PG_PASSWORD]
      );

      console.log("Application database role created.");
    } else {
      console.log("Application database role already exists.");
    }

    // Keep the role's password synchronized with Secrets Manager.
    await executeFormattedQuery(
      "SELECT format('ALTER ROLE %I WITH LOGIN PASSWORD %L', $1, $2) AS statement",
      [APP_PG_USER, APP_PG_PASSWORD]
    );

    // Allow the application to connect to its database.
    await executeFormattedQuery(
      "SELECT format('GRANT CONNECT ON DATABASE %I TO %I', $1, $2) AS statement",
      [PG_DATABASE, APP_PG_USER]
    );

    // Allow the application to create and use objects in public.
    await executeFormattedQuery(
      "SELECT format('GRANT USAGE, CREATE ON SCHEMA public TO %I', $1) AS statement",
      [APP_PG_USER]
    );

    // Allow CRUD operations on existing public tables.
    await executeFormattedQuery(
      "SELECT format('GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO %I', $1) AS statement",
      [APP_PG_USER]
    );

    // Allow access to existing sequences, including SERIAL sequences.
    await executeFormattedQuery(
      "SELECT format('GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO %I', $1) AS statement",
      [APP_PG_USER]
    );

    console.log("Database role and application privileges initialized.");
  } catch (error) {
    // Do not print credentials or the full database error.
    console.error("Database initialization failed.", {
      code: error.code ?? "UNKNOWN",
    });

    process.exitCode = 1;
  } finally {
    await client.end().catch(() => {});
  }
}

await initializeDatabase();
