import mongoose from "mongoose"

mongoose.connect("mongodb+srv://leticiafranca:nzkYM74nJPJUlCdn@cluster0.qgqahtp.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0");

let db = mongoose.connection;

export default db;