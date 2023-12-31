import * as db from "../db.js"
import { Router } from "express";

const router = new Router()

router.get("/:tournamentId", async (req, res) => {
    try {
        const {tournamentId} = req.params
        const players = await db.getTournamentPlayers(parseInt(tournamentId))
        res.status(200).send(players)
    } catch(e) {
        console.error(e);
        res.sendStatus(500)
    }
})

router.post("/", async (req, res) => {
    const player = req.body
    try {
        const result = await db.insertPlayer(player)
        typeof result === "undefined" ? res.sendStatus(400) : res.status(201).send(result)
    } catch (e) {
        console.error(e);
        res.sendStatus(500)
    }
})

export default router
