import * as db from "../db.js"
import { Router } from "express";

const router = new Router()

router.get("/:tournamentId/:roundNumber", async (req, res) => {
    try {
        const {tournamentId, roundNumber} = req.params
        const byes = await db.getTournamentByesByRound(tournamentId, roundNumber)
        byes.length === 0 ? res.sendStatus(404) : res.status(200).send(await Promise.all(byes.map(async (b) => Object.assign(b, {player: await db.getPlayerById(b.PlayerId)}))))
    } catch (error) {
        console.error(error);
        res.sendStatus(500)
    }
})

router.post("/", async (req, res) => {
    try {
        const bye = req.body
        await db.insertBye(bye)
        res.sendStatus(204)
    } catch(error) {
        console.error(error);
        res.sendStatus(500)
    }
})

export default router
