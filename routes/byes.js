import * as db from "../db.js"
import { Router } from "express";

const router = new Router()

router.get("/:tournamentId", async (req, res) => {
    const {tournamentId} = req.params
    let {round} = req.query;
    round = typeof round === "undefined" ? null : parseInt(round)
    if(Number.isNaN(round)) {
        res.sendStatus(400)
        return
    }
    try {
        const byes = await db.getTournamentByesByRound(tournamentId, round)
        byes.length === 0 ? res.sendStatus(404) : res.status(200).send(await Promise.all(byes.map(async (b) => Object.assign(b, {player: await db.getPlayerById(b.PlayerId)}))))
    } catch (error) {
        console.error(error);
        res.sendStatus(500)
    }
})

router.post("/", async (req, res) => {
    const bye = req.body
    try {
        await db.insertBye(bye)
        res.sendStatus(204)
    } catch(error) {
        console.error(error);
        res.sendStatus(500)
    }
})

export default router
