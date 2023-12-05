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
        const standings = await db.getTournamentStandingsByRound(tournamentId, round)
        standings.length === 0 ? res.sendStatus(404) : res.status(200).send(standings)
    } catch (error) {
        console.error(error);
        res.sendStatus(500)
    }
})

router.post("/", async (req, res) => {
    const standing = req.body
    try {
        await db.insertStanding(standing)
        res.sendStatus(204)
    } catch (error) {
        console.error(error);
        res.sendStatus(500)
    }
})

export default router
