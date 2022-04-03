const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const cors = require("cors");
const dotenv = require("dotenv");

const app = express();
require("dotenv").config();
//Port number
const PORT = process.env.PORT || 8070;

app.use(cors());
app.use(bodyParser.json());

//Call the mongodb url
const URL = process.env.MONGODB_URL;

mongoose.connect(URL, {
    useCreateIndex: true,
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false
})

//Check the MongoDB connection
const connection = mongoose.connection;
connection.once("open", () => {
    console.log("MongoDB Connection success!");
})

//import routes
const flowersRouter = require("./routes/flowers");
const userRouter = require('./routes/user.js');
<<<<<<< HEAD
const diseaseRouter = require('./routes/disease.js');
=======
const fertilizerRouter = require('./routes/fertilizerRoute');
>>>>>>> 607477608b3edefba388f8dd06b25a66412f0b61

//calling routes
app.use("/flowers",flowersRouter);
app.use("/users",userRouter);
<<<<<<< HEAD
app.use("/diseases",diseaseRouter);
=======
app.use("/fertilizer",fertilizerRouter);
>>>>>>> 607477608b3edefba388f8dd06b25a66412f0b61

app.listen(PORT, () => {
    console.log("Server is up and running")
})
