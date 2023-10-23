import e from "express";
import cors from "cors"
import * as db from "./db.js"

const app = e()
const port = 5000

app.use(cors())

app.get("/tournaments", async (req, res) => {
    const tournaments = await db.getTournaments()
    res.status(200).send(tournaments)
})

app.get("/tournaments/:id", (req, res, next) => {
    const {id} = req.params
    Number.isInteger(parseInt(id)) ? next() : res.sendStatus(400)
}, async (req, res) => {
    try {
        const {id} = req.params
        const tournament = await db.getTournamentById(parseInt(id))
        res.status(200).send(tournament)
    } catch {
        res.sendStatus(500)
    }
})

app.get("/tournaments/:id/players", (req, res, next) => {
    const {id} = req.params
    Number.isInteger(parseInt(id)) ? next() : res.sendStatus(400)
}, async (req, res) => {
    try {
        const {id} = req.params
        const players = await db.getTournamentPlayers(parseInt(id))
        res.status(200).send(players)
    } catch {
        res.sendStatus(500)
    }
})

app.get("/tournaments/:id/:roundNumber/pairings", (req, res, next) => {
    const {id} = req.params
    Number.isInteger(parseInt(id)) ? next() : res.sendStatus(400)
}, (req, res, next) => {
    const {roundNumber} = req.params
    Number.isInteger(parseInt(roundNumber)) ? next() : res.sendStatus(400)
}, async (req, res, next) => {
    const {id, roundNumber} = req.params
    const tournament = await db.getTournamentById(id)
    parseInt(roundNumber) <= tournament.currentRound && parseInt(roundNumber) > 0 ? next() : res.sendStatus(404)
}, async (req, res) => {
    try {
        const {id, roundNumber} = req.params
        const players = await db.getTournamentPairingsByRound(parseInt(id), parseInt(roundNumber))
        res.status(200).send(players)
    } catch {
        res.sendStatus(500)
    }
})

app.get("/tournaments/:id/:roundNumber/standings", (req, res, next) => {
    const {id} = req.params
    Number.isInteger(parseInt(id)) ? next() : res.sendStatus(400)
}, (req, res, next) => {
    const {roundNumber} = req.params
    Number.isInteger(parseInt(roundNumber)) ? next() : res.sendStatus(400)
}, async (req, res, next) => {
    const {id, roundNumber} = req.params
    const tournament = await db.getTournamentById(id)
    parseInt(roundNumber) <= tournament.currentRound && parseInt(roundNumber) > 0 ? next() : res.sendStatus(404)
}, async (req, res) => {
    try {
        const {id, roundNumber} = req.params
        const players = await db.getTournamentStandingsByRound(parseInt(id), parseInt(roundNumber))
        res.status(200).send(players)
    } catch {
        res.sendStatus(500)
    }
})

app.listen(port, () => {
    console.log("app listening on port", port);
})
