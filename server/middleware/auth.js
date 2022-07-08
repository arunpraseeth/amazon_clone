const jwt = require('jsonwebtoken');

const auth = async(req, res, next)=> {
    try{
        const token = req.header('authToken');
        if(!token) return res.status(401).json({msg: "No authtoken, access denied!"});
        const verified = jwt.verify(token, "passwordKey");
        if(!verified) res.status(401).json({msg: "Token verification failed, authorisation denied."});
        req.id = verified.id;
        req.token = token;
        next();
    }catch (err){
        res.status(500).json({error: err.message});
    }
}

module.exports = auth;