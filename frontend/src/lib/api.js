import axios from "axios";
import { axiosInstance } from "./axios.js";

// You can add reusable API functions here using axiosInstance
// Example: export const getItems = async () => await axiosInstance.get('/items');

export const getAuthUser = async () => {
  try {
    const res = await axiosInstance.get("/auth/me");
    return res.data;
  } catch (error) {
    console.log("Error in getAuthUser:", error);
    return null;
  }
};