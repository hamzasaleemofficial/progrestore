import express from "express";
import helmet from "helmet";
import morgan from "morgan";
import cors from "cors";
import dotenv from "dotenv";
import path from "path";

import productRoutes from "./routes/productRoutes.js";
import { client, connectToPostgres } from "./config/db.js";
import { aj } from "./lib/arcjet.js";

dotenv.config();

const app = express();
const PORT =  5000;
const __dirname = path.resolve();

app.use(express.json());
app.use(cors());

app.use(
  helmet({
    contentSecurityPolicy: false,
  })
);

app.use(morgan("dev"));

// app.use(async (req, res, next) => {
//   try {
//     const decision = await aj.protect(req, {
//       requested: 1,
//     });

//     if (decision.isDenied()) {
//       if (decision.reason.isRateLimit()) {
//         return res.status(429).json({
//           error: "Too Many Requests",
//         });
//       }

//       if (decision.reason.isBot()) {
//         return res.status(403).json({
//           error: "Bot access denied",
//         });
//       }

//       return res.status(403).json({
//         error: "Forbidden",
//       });
//     }

//     next();
//   } catch (error) {
//     console.log("Arcjet error", error);
//     next(error);
//   }
// });

// Health check


app.get("/health", (req, res) => {
  res.status(200).json({
    status: "UP",
    message: "Application is healthy",
  });
});

app.use("/api/products", productRoutes);

async function initDB() {
  try {
    await client.query(`
      CREATE TABLE IF NOT EXISTS products (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        image VARCHAR(255) NOT NULL,
        price DECIMAL(10, 2) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `);

    console.log("Database initialized successfully");
  } catch (error) {
    console.error("Error initDB:", error);
    throw error;
  }
}

async function startServer() {
  try {
    await connectToPostgres();

    await initDB();

    app.listen(PORT, "0.0.0.0",() => {
      console.log(`Server is running on port ${PORT}`);
    });
  } catch (error) {
    console.error("Failed to start server:", error);
    process.exit(1);
  }
}

startServer();