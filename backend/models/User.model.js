import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
    fullName: String,
    username: String,
    email: {
        type: String,
        unique: true,
        sparse: true,
        lowercase: true,
        trim: true
    },
    phone: {
        type: String,
        unique: true
    },
    password: String,
    profileImage: String,
    gender: String,
    dob: Date,
    isVerified: {
        type: Boolean,
        default: false
    },
    isBlocked: {
        type: Boolean,
        default: false
    }
}, {
    timestamps: true
});

const User = mongoose.model("User", userSchema);

export default User
