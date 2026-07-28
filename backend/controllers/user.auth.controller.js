import express from 'express'
import User from "../models/user.model.js";



// ====================== LOGIN ======================

export const getLogin = async (req, res) => {

    console.log("\n========== LOGIN REQUEST ==========");
    console.log("Request Body:", req.body);

    try {

        const { login, password } = req.body;

        // Validation
        if (!login || !password) {

            console.log("Login Failed : Missing login or password.");

            return res.status(400).json({
                success: false,
                message: "Email/Username and password are required."
            });

        }

        // Find User
        const user = await User.findOne({
            $or: [
                { email: login.toLowerCase() },
                { username: login.toLowerCase() }
            ]
        });

        if (!user) {

            console.log(`Login Failed : User not found (${login})`);

            return res.status(404).json({
                success: false,
                message: "Invalid credentials."
            });

        }

        // Password Check
        if (password !== user.password) {

            console.log(`Login Failed : Wrong password (${user.username})`);

            return res.status(401).json({
                success: false,
                message: "Invalid credentials."
            });

        }

        console.log(`Login Success : ${user.username}`);
        console.log("===================================\n");

        return res.status(200).json({
            success: true,
            message: "Login successful.",
            user: {
                id: user._id,
                fullName: user.fullName,
                username: user.username,
                email: user.email,
                phone: user.phone,
                profileImage: user.profileImage
            }
        });

    } catch (error) {

        console.log("Login Error");
        console.error(error);
        console.log("===================================\n");

        return res.status(500).json({
            success: false,
            message: "Internal server error."
        });

    }

};



// ====================== SIGNUP ======================

export const handleSignup = async (req, res) => {

    console.log("\n========== SIGNUP REQUEST ==========");
    console.log("Request Body:", req.body);

    try {

        const {
            fullName,
            username,
            email,
            phone,
            password,
            gender,
            dob
        } = req.body;

        // Validation
        if (!fullName || !username || !email || !phone || !password) {

            console.log("Signup Failed : Missing required fields.");

            return res.status(400).json({
                success: false,
                message: "Please fill all required fields."
            });

        }

        // Email Exists
        const emailExists = await User.findOne({ email });

        if (emailExists) {

            console.log(`Signup Failed : Email already exists (${email})`);

            return res.status(400).json({
                success: false,
                message: "Email already exists."
            });

        }

        // Username Exists
        const usernameExists = await User.findOne({ username });

        if (usernameExists) {

            console.log(`Signup Failed : Username already exists (${username})`);

            return res.status(400).json({
                success: false,
                message: "Username already exists."
            });

        }

        // Phone Exists
        const phoneExists = await User.findOne({ phone });

        if (phoneExists) {

            console.log(`Signup Failed : Phone already exists (${phone})`);

            return res.status(400).json({
                success: false,
                message: "Phone number already exists."
            });

        }

        // Create User
        const user = new User({
            fullName,
            username,
            email,
            phone,
            password,
            gender,
            dob
        });

        await user.save();

        console.log(`Signup Success : ${username}`);
        console.log("====================================\n");

        return res.status(201).json({
            success: true,
            message: "Account created successfully.",
            user
        });

    } catch (error) {

        console.log("Signup Error");
        console.error(error);
        console.log("====================================\n");

        return res.status(500).json({
            success: false,
            message: "Internal server error."
        });

    }

};

// ====================== SIGNUP ======================

export const getHome = async (req,res) => {
    try{

    }catch(error){
        
    }
}