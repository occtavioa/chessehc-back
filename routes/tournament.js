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
    const tournament = req.body
    try {
        const result = await db.insertTournament(tournament)
        typeof result === "undefined" ? res.sendStatus(400) : res.status(200).send(result)
    } catch(e) {
        console.error(e);
        res.sendStatus(500)
    }
})

router.get("/:id", async (req, res) => {
    const {id} = req.params
    try {
        const tournament = await db.getTournamentById(parseInt(id))
        typeof tournament === "undefined" ? res.sendStatus(404) : res.status(200).send(tournament)
    } catch(e) {
        console.error(e);
        res.sendStatus(500)
    }
})

router.put("/:id/round", async (req, res) => {
    const {id} = req.params
    const {round} = req.body
    if(typeof round === "undefined") {
        res.sendStatus(400)
        return
    }
    try {
        await db.updateTournamentRound(parseInt(id), round)
        res.sendStatus(204)
    } catch (error) {
        console.error(error)
        res.sendStatus(500)
    }
})

export default router
