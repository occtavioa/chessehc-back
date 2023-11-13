import * as db from "../db.js"
import { Router } from "express";

const router = new Router()

router.get("/", async(_req, res) => {
    try {
        const tournaments = await db.getTournaments()
        res.status(200).send(tournaments)
    } catch(e) {
        console.error(e)
        res.sendStatus(500)
    }
})

router.post("/", async (req, res) => {
    try {
        const body = req.body
        const {Id} = await db.insertTournament(body)
        res.status(200).send({id: Id})
    } catch(e) {
        console.error(e);
        res.sendStatus(500)
    }
})

router.get("/:id", async (req, res) => {
    try {
        const {id} = req.params
        const tournament = await db.getTournamentById(parseInt(id))
        typeof tournament === "undefined" ? res.sendStatus(404) : res.status(200).send({
            id: tournament.Id,
            name: tournament.Name,
            numberOfRounds: tournament.NumberOfRounds,
            currentRound: tournament.CurrentRound
        })
    } catch(e) {
        console.error(e);
        res.sendStatus(500)
    }
})

export default router
