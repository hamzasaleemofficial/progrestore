import { Client } from "pg";
import {
  SecretsManagerClient,
  GetSecretValueCommand,
} from "@aws-sdk/client-secrets-manager";

const secretsClient = new SecretsManagerClient({
  region: "eu-west-1",
});

const secretName = "postgres-testDB";

let client;

async function connectToPostgres() {
  try {
    const response = await secretsClient.send(
      new GetSecretValueCommand({
        SecretId: secretName,
        VersionStage: "AWSCURRENT",
      })
    );

    const secret = JSON.parse(response.SecretString);

    // console.log("Secret retrieved successfully");
    // console.log("Database host:", secret.host);
    // console.log("Database:", secret.dbname);
    // console.log("User:", secret.username);
    // console.log ("Password", secret.password);

    client = new Client({
      user: secret.username,
      host: secret.host,
      database: secret.dbname,
      password: secret.password,
      port: Number(secret.port),
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