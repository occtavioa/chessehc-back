import * as db from "../db.js"
import { Router } from "express";

const router = new Router()

router.get("/:tournamentId/:roundNumber", async (req, res) => {
    try {
        const {tournamentId, roundNumber} = req.params
        const standings = await db.getTournamentStandingsByRound(tournamentId, roundNumber)
        standings.length === 0 ? res.sendStatus(404) : res.status(200).send(standings)
    } catch (error) {
        console.error(error);
        res.sendStatus(500)
    }
})

router.post("/", async (req, res) => {
    try {
        const standing = req.body
        await db.insertStanding(standing)
        res.sendStatus(204)
    } catch (error) {
        console.error(error);
        res.sendStatus(500)
    }
})

export default router
