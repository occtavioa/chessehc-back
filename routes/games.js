import * as db from "../db.js"
import { Router } from "express";

const router = new Router()

router.get("/:tournamentId", async (req, res) => {
    const {tournamentId} = req.params
    let {roundNumber} = req.query;
    roundNumber = typeof roundNumber === "undefined" ? null : parseInt(roundNumber)
    if(Number.isNaN(roundNumber)) {
        res.sendStatus(400)
        return
    }
    try {
        const games = await db.getTournamentGamesByRound(tournamentId, roundNumber)
        games.length === 0 ? res.sendStatus(404) : res.status(200).send(await Promise.all(games.map(async (g) => Object.assign(g, {white: await db.getPlayerById(g.WhiteId), black: await db.getPlayerById(g.BlackId)}))))
    } catch (error) {
        console.error(error);
        res.sendStatus(500)
    }
})

router.post("/", async (req, res) => {
    try {
        const game = req.body
        const result = await db.insertGame(game)
        typeof result === "undefined" ? res.sendStatus(400) : res.status(201).send(result)
    } catch (error) {
        console.error(error);
        res.sendStatus(500)
    }
})

export default router
