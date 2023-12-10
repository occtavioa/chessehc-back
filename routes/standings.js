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
        res.sendStatus(201)
    } catch (error) {
        console.error(error);
        res.sendStatus(500)
    }
})

router.put("/", async (req, res) => {
    let {tournamentId, playerId, round} = req.query
    tournamentId = typeof tournamentId === "undefined" ? null : parseInt(tournamentId)
    playerId = typeof playerId === "undefined" ? null : parseInt(playerId)
    round = typeof round === "undefined" ? null : parseInt(round)
    if(Number.isNaN(tournamentId) || Number.isNaN(playerId) || Number.isNaN(round)) {
        res.sendStatus(400)
        return
    }
    const {points} = req.body
    if(typeof points !== "number" || points < 0) {
        res.sendStatus(400)
        return
    }
    try {
        await db.updateStanding(tournamentId, playerId, round, points)
        res.sendStatus(204)
    } catch (error) {
        console.error(error);
        res.sendStatus(500)
    }
})

export default router
