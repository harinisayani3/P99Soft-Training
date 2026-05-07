import portsRouter from "./routes/ports.routes.js"
import express from "express"
import { errorHandler } from "./utils/apiError.js";


const app = express();

const PORT = 3000;

app.use(express.json());

app.use((req, _res, next) => {
    console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
    next();
})

// app.get("/",(_req,res)=>{
//     res.json({message:"PORT API running"});
// })
// app.use("/",portsRouter);
app.use("/ports", portsRouter);
app.use((_req, res) => {
    res.status(404).json({ success: false, error: "Route not found" });
});

app.use(errorHandler);

app.listen(PORT, () => {
    console.log(`Ports API running on http://localhost:${PORT}`);
})

