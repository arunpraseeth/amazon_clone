const express = require('express')

const authRouter = express.Router();

authRouter.post('/api/signup',(req,res)=>{
    console.log(req.body);
    // Get the data from client - email, password
    const {name,email,password} = req.body;

    // Post data to database
    
    // Return some data to user
});


module.exports = authRouter;