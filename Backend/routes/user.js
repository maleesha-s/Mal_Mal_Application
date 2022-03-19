const router = require("express").Router();
let User = require('../models/User.js');

//add a new Flower
router.route("/addUser").post((req, res) => {
    const {userName,firstName,lastName,password,userType} = req.body;

    const newUser = new User({
        userName,
        firstName,
        lastName,
        password,
        userType
    });
    newUser.save().then(() =>{
        res.json("User Added Successfully")
    }).catch((err)=>{
        console.log(err);
    })
})
//login
router.route("/login").post((req,res)=>{
    const {userName,password} = req.body;
    User.find({userName:userName,password:password}).then((user =>{
        res.json(user);
    })).catch((err)=>{
        console.log(err);
    })
});
//get all users
router.route("/").get((req,res)=>{
    User.find().then((users =>{
        res.json(users)
    })).catch((err)=>{
        console.log(err)
    })
})

//update User
router.route("/update/:id").put(async (req, res)=>{
    let userName = req.params.userName;
    const {firstName, lastName, password} = req.body;

    const updateUser = {
        firstName,
        lastName,
        password
    }
    const update = await User.findByIdAndUpdate(userName, updateUser).then(()=> {
        res.status(200).send({status: "User updated"})
    }).catch((err)=>{
        console.log(err);
        res.status(500).send({status: "Error with updating data"});

    })

})

//delete User
router.route("/delete/:id").delete(async (req, res)=>{
    let userName= req.params.userName;
    await User.findByIdAndDelete(userName).then(()=>{
        res.status(200).send({status: "User Deleted Successfully"});
    }).catch((err)=>{
        console.log(err.message);
        res.status(500).send({status: "Error with delete "+ err.message});
    })
})




module.exports = router;