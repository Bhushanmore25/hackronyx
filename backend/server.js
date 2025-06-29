import express from "express";
import mongoose from "mongoose";
import dotenv from "dotenv";
import cors from "cors";
import authRoutes from "./routes/auth.routes.js";
import cookieParser from "cookie-parser";
import userRoutes from "./routes/user.routes.js"
import aiRoutes from "./routes/aiRoutes.js";
import codeRoutes from "./routes/code.routes.js";
dotenv.config();
const app = express();

// CORS configuration for production
const allowedOrigins = [
  "http://localhost:5173",
  "http://localhost:3000",
  "https://your-frontend-domain.onrender.com", // Replace with your actual frontend domain
  process.env.FRONTEND_URL // Add this to your environment variables
];

app.use(cors({ 
  origin: function (origin, callback) {
    // Allow requests with no origin (like mobile apps or curl requests)
    if (!origin) return callback(null, true);
    if (allowedOrigins.indexOf(origin) !== -1) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  credentials: true 
}));

app.use(express.json());
app.use(cookieParser()); 

app.use("/api/auth", authRoutes);
app.use("/api/user", userRoutes);
app.use("/api/code", codeRoutes);
app.use("/api/chatbot", aiRoutes);

// Health check endpoint
app.get("/health", (req, res) => {
  res.status(200).json({ status: "OK", message: "Server is running" });
});

// Root endpoint
app.get("/", (req, res) => {
  res.status(200).json({ message: "HRX Genius Grid Backend API" });
});

const PORT = process.env.PORT || 5000;

mongoose.connect(process.env.MONGO_URI).then(() => {
  console.log("MongoDB connected");
  app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
}).catch((error) => {
  console.error("MongoDB connection error:", error);
  process.exit(1);
});