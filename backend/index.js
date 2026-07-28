import express from 'express';
import dotenv from "dotenv";
import connectDB from './CONFIG/db.config.js';
import userAuthRouter from './router/apiUserAuth.router.js';

dotenv.config()

const PORT = process.env.PORT || 3000
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

await connectDB()

// Mount the router
app.use('/api', userAuthRouter);



app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});