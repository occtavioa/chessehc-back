import * as db from "../db.js"
import { Router } from "express";

const router = new Router()

router.get("/:tournamentId", async (req, res) => {
    try {
        const {tournamentId} = req.params
        const players = await db.getTournamentPlayers(parseInt(tournamentId))
        res.status(200).send(players.map(p => ({
            id: p.Id,
            name: p.Name,
            rating: p.Rating,
            title: p.Title,
            points: p.Points
        })))
    } catch(e) {
        console.error(e);
        res.sendStatus(500)
    }
})

router.post("/", async (req, res) => {
    try {
        const player = req.body
        const result = await db.insertPlayer(player)
        typeof result === "undefined" ? res.sendStatus(400) : res.status(201).send({id: result.Id})
    } catch (e) {
        console.error(e);
        res.sendStatus(500)
    }
})

export default router
