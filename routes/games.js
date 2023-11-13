import * as db from "../db.js"
import { Router } from "express";

const router = new Router()

router.get("/:tournamentId/:roundNumber", async (req, res) => {
    try {
        const {tournamentId, roundNumber} = req.params
        const games = await db.getTournamentGamesByRound(tournamentId, roundNumber)
        games.length === 0 ? res.sendStatus(404) : res.status(200).send(games)
    } catch (error) {
        console.error(error);
        res.sendStatus(500)
    }
})

router.post("/", async (req, res) => {
    try {
        const game = req.body
        const result = await db.insertGame(game)
        typeof result === "undefined" ? res.sendStatus(400) : res.status(201).send({id: result.Id})
    } catch (error) {
        console.error(error);
        res.sendStatus(500)
    }
})

export default router
