import {Router} from "express";
import { createPort, deletePort, getAllPorts } from "../controllers/ports.controller.js";
import { getPortByCode } from "../controllers/ports.controller.js";
const router = Router();

router.get("/", getAllPorts);
router.get("/ports/:code", getPortByCode);
router.post("/",createPort);
router.delete("/:code", deletePort);

export default router;
