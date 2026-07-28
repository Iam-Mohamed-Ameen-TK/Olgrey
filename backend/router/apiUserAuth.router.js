import express from 'express'
import {getLogin,handleSignup} from '../controllers/user.auth.controller.js'

const router = express.Router()

router.get('/login', getLogin)
router.post('/signup', handleSignup)

router.get('/profile')

export default router